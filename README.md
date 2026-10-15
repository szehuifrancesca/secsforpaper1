# School-Based Exam Control System (SECS)
### Designed for School-Based Paper 1 (Writing) Examination Control & Standardisation

SECS is a professional, offline-first local web application created to replace error-prone spreadsheets for school-based Paper 1 (Writing) marking. It strictly adheres to rigorous examination quality assurance and standardisation protocols while providing seamless usability for teachers marking hardcopy physical papers.

---

## 🚀 Quick Start Instructions

1. **Launch**:
   - Double-click `start_secs.bat` or open `index.html` directly in **Google Chrome** or **Microsoft Edge**.
   - No server, Node.js, or internet connection required.
2. **Confidential Role-Based Authentication**:
   - **Exam Markers**: Enter the school-issued **Marker Passcode** (distributed privately by your Exam Lead / HOD) &rarr; Select your assigned Marker Code (e.g. `M01` to `M04`) to begin isolated physical script scoring.
   - **KP Moderators (Senior Teachers / Level Heads)**: Log in with the standard Marker Passcode and assigned code. If designated as Key Personnel (KP) by the HOD, a dedicated **⭐ KP Moderation & Script Sampling Hub** tab activates automatically inside the Marker Portal, enabling script sampling and moderation without requiring full administrative HOD access.
   - **HOD / Exam Lead**: Enter the confidential **HOD Master Passcode** (issued only to Examination Chairs / HODs) &rarr; Grants full administrative access to paper management, class bundles, cohort consolidation, rubric settings, archived papers, and official reports.
   - *(Note: All passcodes are confidential security controls and are never displayed in user prompts or printed in documentation).*

---

## 🎯 Key Capabilities & Design Aligned with Your Request

### 1. Hybrid & Blind Marking Protocol
- **Hybrid Physical Script Marking**: When teachers mark hardcopy papers, they can quickly filter by **Form Class** or **Mother Tongue Class**, select the student's name/register number, and record marks.
- **Confidentiality & Anti-Bias Shield**: Markers **never** see other markers' scores, peer marking speeds, or other students' marks. Double marking is prevented.
- **Blind Mode Toggle**: HOD can switch on "Enforce Full Blind Marking" under Settings to mask student names into **Script IDs / Candidate Numbers** (`SC-001...`) at any time.

### 2. Flexible Roster & Marker Setup (First Setup by HOD)
- **Exam Cohort Definition**: Directly edit Level/Cohort (e.g. `Primary 4`), Subject (e.g. `Mother Tongue (Chinese)`), and Exam Title with instant global sync.
- **Multi-Class Student Upload**: Upload CSV containing multiple Form Classes and Mother Tongue Classes. Choose to **"Append"** (add classes incrementally) or **"Replace Entire Roster"** (start fresh cohort).
- **Downloadable CSV Template**: One-click download of a standard roster CSV template.
- **Edit & Delete Records**: Edit any student's Name, Class, or Register Number; delete individual students or click **"Remove All"** to clear the roster.
- **Marker Team Controls**: Register new markers (`M01, M02...`), rename markers, remove individual markers, or clear all markers. All assignments update cleanly in the database.

### 3. Standardized Rubrics with Dynamic Validation
- **Primary 3 & 4 Mother Tongue**: Content max 7, Language max 8 (Total = 15).
- **Primary 5 & 6 Mother Tongue**: Content max 20, Language max 20 (Total = 40).
- **Primary English Paper 1**: Content max 20, Language max 20 (Total = 40).
- **HOD Rubric Customizer**: Set custom minimum and maximum bounds for any level or subject.
- **Real-Time Input Guard**: Prevents clerical typos (e.g. typing `21` when max is `20`) with instant visual error blocks.

### 4. Quick-Click Qualitative Feedback Tags
- **Content Feedback Tags**: *Engaging Plot / 生动情节, Logical Progression / 结构清晰, Good Climax / 高潮突出, Weak Development / 内容空洞, Off-topic / 偏题离题, Incomplete Story / 未完篇...*
- **Language Feedback Tags**: *Rich Vocabulary & Idioms / 好词佳句·成语恰当, Varied Sentence Structures / 句式多样, Accurate Grammar / 语法通顺, Tense Slips / 错别字·时态错误, Punctuation Errors / 标点不当...*
- **Teacher Qualitative Remarks**: Free-text field for specific student coaching notes.

### 5. HOD & Key Personnel (KP) Moderation & Sample Checking (Standardisation & Quality Checks)
- **Dedicated KP Moderation Hub**: Key Personnel (Senior Teachers, Level Heads) can access a dedicated Moderation tab directly within the Marker Portal to sample, review, and moderate scripts without needing HOD master administrative privileges.
- **Intelligent Standardisation Sampling Filters**:
  - *Recommended Combined Sampling*: Intelligently combines all critical sampling triggers into one curated queue.
  - *Borderline Pass (48% - 52%)*: Flags students right at the passing threshold.
  - *Borderline Quality Pass (78% - 82%)*: Flags students hovering near distinction.
  - *Content / Language Discrepancy*: Detects unbalanced writing (>20% criterion discrepancy).
  - *Random 10% Sample*: Automatic random cross-audit.
  - *Pupils-at-Risk (PAR < 50%)*: Rapid intervention sampling.
  - *Unmarked Scripts*: Instant view of remaining hardcopy scripts waiting to be marked.
- **Side-by-Side Audit Drawer**: View original marker's scores, tags, and teacher notes side-by-side with moderation inputs. System calculates live Variance Delta ($\Delta$). Enter moderation rationale and save audit logs seamlessly.

### 6. Comprehensive Item Analysis & Marker Calibration
- **Cohort Descriptive Statistics**: Mean, Content Mean, Language Mean, Median, Min, Max, Standard Deviation ($\sigma$).
- **Benchmark Indicators**: Pass Rate ($\ge 50\%$), Quality Pass Rate ($\ge 80\%$), and Pupils-at-Risk (PAR $< 50\%$).
- **Mother Tongue vs Form Class Comparative Breakdowns**: Evaluates banded MT classes against general form classes.
- **Marker Calibration & Reliability Index**: Evaluates marker grading tendencies (Strict "Hawk" vs Lenient "Dove" vs Calibrated) and tracks sample audit variance.

### 7. Multi-Format Export & Sharing
- **Excel Workbook (`.xlsx`)**: Multi-sheet workbook containing Master Consolidated Marks, Item Analysis, Class Breakdowns, and Marker Calibration logs.
- **Word Document (`.doc`)**: Fully formatted post-examination review report ready for department meeting minutes and HOD/Principal endorsement.
- **Print / PDF Summary**: Formatted print layout for school filing and archiving.
- **Email Sharing**: One-click summary generation with clipboard copy and `mailto:` launch.
- **JSON Backup & Restore**: Full offline database snapshot saving.

---

## 🔒 Data Privacy, Compliance & Security
- **100% Local**: All student data is stored strictly in the user's browser storage (`localStorage`). No student records or marks are ever sent to external cloud servers.
- **SOE-OE Ready**: Runs natively in Chrome / Edge without requiring administrator installation rights on school laptops.
