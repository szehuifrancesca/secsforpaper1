$dir = "EXAM DATA FOLDER (LINK TO THIS FOLDER)\secs_sync"
$backupDir = Join-Path $dir "backup_before_partitioning"
if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

# Bounds dictionary
$bounds = @{
    "exam_1791451628276" = @{ cMax = 7; lMax = 8; tMax = 15; title = "P3 EOY P1" }
    "exam_1791294321657" = @{ cMax = 7; lMax = 8; tMax = 15; title = "P4 EOY P1" }
    "exam_1790839964069" = @{ cMax = 20; lMax = 20; tMax = 40; title = "P5 EOY P1" }
    "exam_1791784978995" = @{ cMax = 20; lMax = 20; tMax = 40; title = "P5 EOY HCL P1" }
}

Write-Output "=== PARTITIONING ALL LEGACY MARKER AND MODERATION FILES ==="

# 1. Process legacy marker files: marker_M*.json
$markerFiles = Get-ChildItem -Path $dir -Filter "marker_M*.json"
foreach ($f in $markerFiles) {
    Copy-Item -Path $f.FullName -Destination (Join-Path $backupDir $f.Name) -Force
    $json = Get-Content -Raw -Encoding UTF8 $f.FullName | ConvertFrom-Json
    $mCode = $f.BaseName.Replace("marker_", "")
    
    # Group marks by examId
    $byExam = @{}
    if ($json.marks) {
        $json.marks.psobject.properties | ForEach-Object {
            $m = $_.Value
            $exId = $m.examId
            if (-not $exId) {
                # Determine from student ID prefix or fallback
                if ($m.studentId -and $m.studentId.StartsWith("STD-1791451671926")) { $exId = "exam_1791451628276" }
                elseif ($m.studentId -and $m.studentId.StartsWith("STD-179129516556")) { $exId = "exam_1791294321657" }
                elseif ($m.studentId -and $m.studentId.StartsWith("STD-1791242816662")) { $exId = "exam_1790839964069" }
                elseif ($m.studentId -and $m.studentId.StartsWith("STD-1791785026055")) { $exId = "exam_1791784978995" }
            }
            if ($exId -and $bounds.ContainsKey($exId)) {
                $b = $bounds[$exId]
                # Validate rubric bounds
                if ($m.score -and $m.score.content -le $b.cMax -and $m.score.language -le $b.lMax) {
                    $m.examId = $exId
                    if (-not $byExam.ContainsKey($exId)) {
                        $byExam[$exId] = @{}
                    }
                    $byExam[$exId][$_.Name] = $m
                }
            }
        }
    }
    
    # Write partitioned files: marker_${examId}_${mCode}.json
    foreach ($exId in $byExam.Keys) {
        $marksObj = $byExam[$exId]
        $targetFileName = "marker_${exId}_${mCode}.json"
        $targetPath = Join-Path $dir $targetFileName
        
        $payload = [PSCustomObject]@{
            examId = $exId
            markerCode = $mCode
            markerName = if ($json.markerName) { $json.markerName } else { "Marker $mCode" }
            lastUpdated = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
            seq = 1
            count = $marksObj.Count
            marks = $marksObj
        }
        
        $jsonStr = $payload | ConvertTo-Json -Depth 10
        [System.IO.File]::WriteAllText($targetPath, $jsonStr, [System.Text.Encoding]::UTF8)
        Write-Output "Created partitioned file: $targetFileName ($($marksObj.Count) marks)"
    }
}

# 2. Process legacy moderation files: moderation*.json
$modFiles = Get-ChildItem -Path $dir -Filter "moderation*.json"
foreach ($f in $modFiles) {
    if ($f.Name -match "^moderation_exam_") { continue } # already partitioned
    Copy-Item -Path $f.FullName -Destination (Join-Path $backupDir $f.Name) -Force
    $json = Get-Content -Raw -Encoding UTF8 $f.FullName | ConvertFrom-Json
    $modBy = if ($f.Name -eq "moderation.json") { "HOD" } else { $f.BaseName.Replace("moderation_", "") }
    
    $byExam = @{}
    if ($json.moderations) {
        $json.moderations.psobject.properties | ForEach-Object {
            $m = $_.Value
            $exId = $m.examId
            if (-not $exId) {
                if ($m.studentId -and $m.studentId.StartsWith("STD-1791451671926")) { $exId = "exam_1791451628276" }
                elseif ($m.studentId -and $m.studentId.StartsWith("STD-179129516556")) { $exId = "exam_1791294321657" }
                elseif ($m.studentId -and $m.studentId.StartsWith("STD-1791242816662")) { $exId = "exam_1790839964069" }
                elseif ($m.studentId -and $m.studentId.StartsWith("STD-1791785026055")) { $exId = "exam_1791784978995" }
            }
            if ($exId -and $bounds.ContainsKey($exId)) {
                $b = $bounds[$exId]
                $valid = $true
                if ($m.score -and ($m.score.content -gt $b.cMax -or $m.score.language -gt $b.lMax)) { $valid = $false }
                if ($m.moderation -and ($m.moderation.hodContent -gt $b.cMax -or $m.moderation.hodLanguage -gt $b.lMax)) { $valid = $false }
                if ($valid) {
                    $m.examId = $exId
                    if (-not $byExam.ContainsKey($exId)) {
                        $byExam[$exId] = @{}
                    }
                    $byExam[$exId][$_.Name] = $m
                }
            }
        }
    }
    
    foreach ($exId in $byExam.Keys) {
        $modsObj = $byExam[$exId]
        $targetFileName = "moderation_${exId}_${modBy}.json"
        $targetPath = Join-Path $dir $targetFileName
        
        $payload = [PSCustomObject]@{
            examId = $exId
            moderatorCode = $modBy
            moderatorName = if ($json.moderatorName) { $json.moderatorName } else { "Moderator $modBy" }
            lastUpdated = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
            seq = 1
            count = $modsObj.Count
            moderations = $modsObj
        }
        
        $jsonStr = $payload | ConvertTo-Json -Depth 10
        [System.IO.File]::WriteAllText($targetPath, $jsonStr, [System.Text.Encoding]::UTF8)
        Write-Output "Created partitioned file: $targetFileName ($($modsObj.Count) moderations)"
    }
}

Write-Output "=== PARTITIONING COMPLETE ==="
