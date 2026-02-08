# Day 7: ML Services, Practice Exam & Final Review

**Goal:** Complete exam coverage + First practice exam  
**Study Time:** 6-8 hours

### 🎯 Learning Goals

By the end of Day 7, you will be able to:

1. **Identify** the purpose of each AWS ML service (Rekognition, Lex, Polly, etc.)
2. **Match** ML service to use case (image analysis, chatbots, translation)
3. **Complete** a full practice exam under timed conditions
4. **Identify** your weak areas for final review
5. **Describe** additional AWS services (WorkSpaces, Connect, IoT)

---

## 📋 Services You'll Meet Today

> This is the final review day. All prior days are prerequisites!

| Day | Core Topics | Status |
|-----|-------------|--------|
| Day 1 | Cloud Concepts, Well-Architected | ✅ Required |
| Day 2 | IAM, Security, Cognito | ✅ Required |
| Day 3 | VPC, Networking, WAF, Shield | ✅ Required |
| Day 4 | EC2, S3, EBS, CloudFront | ✅ Required |
| Day 5 | RDS, DynamoDB, Lambda, Containers | ✅ Required |
| Day 6 | SQS, SNS, CloudWatch, Billing | ✅ Required |

📖 **Quick Reference:** [AWS Glossary](../notes/glossary.md)

---

## 📖 How to Use This Resource

1. **Study ML services first** (1-2 hours) - know what each does
2. **Take a full practice exam** (65 questions, 90 minutes)
3. **Review ALL wrong answers** - understand why you missed them
4. **Focus on weak areas** for remaining study time

> [!IMPORTANT]
> **Day 7 is exam simulation day!** Treat the practice exam like the real thing - no notes, timed, quiet environment.

---

## 🤖 Part 1: Machine Learning Services

### Why ML Services Matter

- CLF-C02 tests your ability to **identify the right ML service for a use case**
- You don't need to know HOW to use them, just WHAT they do
- Focus on the **keyword → service** mapping

---

### ML Services Quick Reference

| Service | Purpose | Keyword/Trigger |
|---------|---------|-----------------|
| **Rekognition** | Image and video analysis | "Detect faces", "identify objects" |
| **Transcribe** | Speech-to-text | "Convert audio to text" |
| **Polly** | Text-to-speech | "Convert text to audio", "read aloud" |
| **Translate** | Language translation | "Translate languages" |
| **Lex** | Chatbots | "Conversational bot", "Alexa" |
| **Comprehend** | Natural Language Processing | "Sentiment analysis", "extract entities" |
| **SageMaker** | Build/train/deploy ML models | "Custom ML", "train models" |
| **Kendra** | Intelligent search | "Enterprise search", "find documents" |
| **Personalize** | Recommendations | "Product recommendations" |
| **Textract** | Extract text from documents | "OCR", "extract from PDF" |

---

### Amazon Rekognition

**What:** Image and video analysis using deep learning.

**Capabilities:**
- Face detection and recognition
- Object and scene detection
- Celebrity recognition
- Content moderation (inappropriate content)
- Text in images

**Exam Pattern:**
> "Detect faces in photos..."
> → Answer: **Rekognition**

---

### Amazon Transcribe

**What:** Automatic speech-to-text service.

**Use Cases:**
- Transcribe customer service calls
- Generate subtitles
- Meeting transcription

**Exam Pattern:**
> "Convert audio recordings to text..."
> → Answer: **Transcribe**

---

### Amazon Polly

**What:** Text-to-speech service using deep learning.

**Use Cases:**
- Generate voice for applications
- Accessibility features
- Voice-enabled content

**Exam Pattern:**
> "Read text aloud to users..."
> → Answer: **Polly**

---

### Amazon Translate

**What:** Neural machine translation service.

**Use Cases:**
- Translate website content
- Real-time chat translation
- Multilingual applications

**Exam Pattern:**
> "Translate content to multiple languages..."
> → Answer: **Translate**

---

### Amazon Lex

**What:** Build conversational interfaces (chatbots).

**Key Point:** Powers Amazon Alexa!

**Use Cases:**
- Customer service bots
- Order tracking bots
- FAQ chatbots

**Exam Pattern:**
> "Build a chatbot for customer service..."
> → Answer: **Lex**

---

### Amazon Comprehend

**What:** Natural Language Processing (NLP) service.

**Capabilities:**
- Sentiment analysis (positive/negative/neutral)
- Entity extraction (names, places, dates)
- Key phrase extraction
- Language detection

**Exam Pattern:**
> "Analyze customer reviews for sentiment..."
> → Answer: **Comprehend**

---

### Amazon SageMaker

**What:** Fully managed platform to build, train, and deploy ML models.

**Key Point:** For CUSTOM ML models (not pre-built services).

**Use Cases:**
- Build custom prediction models
- Train models on your data
- Deploy models at scale

**Exam Pattern:**
> "Build and train a custom machine learning model..."
> → Answer: **SageMaker**

---

### Amazon Kendra

**What:** Intelligent enterprise search service.

**Use Cases:**
- Search company documents
- Knowledge base search
- FAQ search

**Exam Pattern:**
> "Search across internal documents intelligently..."
> → Answer: **Kendra**

---

### Amazon Personalize

**What:** Real-time personalization and recommendations.

**Use Cases:**
- Product recommendations
- Personalized content
- Targeted marketing

**Exam Pattern:**
> "Provide personalized product recommendations..."
> → Answer: **Personalize**

---

### Amazon Textract

**What:** Extract text and data from scanned documents.

**Capabilities:**
- OCR (Optical Character Recognition)
- Extract tables and forms
- Process invoices and receipts

**Exam Pattern:**
> "Extract text from scanned PDFs..."
> → Answer: **Textract**

---

### Amazon Q

**What:** Generative AI-powered assistant for business.

**Use Cases:**
- Answer questions using company data
- Generate content
- Code assistance (Amazon Q Developer)

**Exam Pattern:**
> "AI assistant for employees to query company knowledge..."
> → Answer: **Amazon Q**

### 📌 Quick Summary: ML Services

| Type | Service |
|------|---------|
| **Vision** | Rekognition (images/video) |
| **Speech** | Transcribe (STT), Polly (TTS) |
| **Language** | Translate, Comprehend (NLP), Lex (chatbots) |
| **Documents** | Textract (OCR), Kendra (search) |
| **Custom ML** | SageMaker (build your own) |
| **Personalization** | Personalize (recommendations) |
| **Gen AI** | Amazon Q (assistant) |

---

## 🏢 Part 2: Additional Services (Minor Topics)

### End User Computing

| Service | Purpose |
|---------|---------|
| **Amazon WorkSpaces** | Virtual desktops (VDI) in the cloud |
| **Amazon AppStream 2.0** | Stream desktop apps to browsers |

**Exam Pattern:**
> "Provide virtual desktops to remote employees..."
> → Answer: **WorkSpaces**

---

### Business Applications

| Service | Purpose |
|---------|---------|
| **Amazon Connect** | Cloud contact center |
| **Amazon SES** | Simple Email Service (bulk email) |

**Exam Pattern:**
> "Build a cloud-based call center..."
> → Answer: **Connect**

---

### IoT Services

| Service | Purpose |
|---------|---------|
| **AWS IoT Core** | Connect and manage IoT devices |

**Exam Pattern:**
> "Manage thousands of IoT sensors..."
> → Answer: **IoT Core**

---

### Other Important Services

| Service | Purpose | Day Covered |
|---------|---------|-------------|
| **Control Tower** | Set up multi-account landing zone | Day 6 |
| **Compute Optimizer** | Right-sizing recommendations | Day 6 |
| **AWS Marketplace** | Buy/sell software | Day 6 |
| **Transit Gateway** | Connect multiple VPCs | Day 3 |
| **AWS Outposts** | Run AWS on-premises | Day 5 |

### 📌 Quick Summary: Additional Services

- **WorkSpaces:** Virtual desktops
- **Connect:** Cloud contact center
- **IoT Core:** Manage IoT devices
- **SES:** Bulk email

---

## 📝 Part 3: Practice Exam Strategy

### Before the Practice Exam

1. **Simulate real conditions:**
   - Quiet environment
   - No notes or resources
   - Set a 90-minute timer
   - 65 questions (50 scored + 15 unscored)

2. **Know the question types:**
   - Multiple choice (1 correct answer)
   - Multiple response (2+ correct answers)

---

### During the Practice Exam

| Strategy | Why |
|----------|-----|
| **Read questions carefully** | Keywords matter! |
| **Eliminate wrong answers first** | Narrow down choices |
| **Flag difficult questions** | Come back later |
| **Don't spend too long on one question** | ~1.5 min per question |
| **Answer every question** | No penalty for guessing |

---

### After the Practice Exam

1. **Review ALL wrong answers** - understand why
2. **Categorize mistakes by domain:**
   - D1: Cloud Concepts (24%)
   - D2: Security (30%)
   - D3: Technology (34%)
   - D4: Billing (12%)

3. **Focus study time on weak domains**

---

### Target Scores

| Score | Status | Action |
|-------|--------|--------|
| **< 65%** | Need more study | Review Days 1-6 again |
| **65-75%** | Getting close | Focus on weak areas |
| **75-85%** | Good progress | Fine-tune weak spots |
| **85%+** | Ready! | Light review, rest |

---

## 🧪 Self-Check Questions

### ML Services

1. **Which service analyzes images for faces and objects?**
   <details><summary>Answer</summary>
   Amazon Rekognition
   </details>

2. **Which service converts speech to text?**
   <details><summary>Answer</summary>
   Amazon Transcribe
   </details>

3. **Which service converts text to speech?**
   <details><summary>Answer</summary>
   Amazon Polly
   </details>

4. **Which service builds chatbots (powers Alexa)?**
   <details><summary>Answer</summary>
   Amazon Lex
   </details>

5. **Which service analyzes sentiment in text?**
   <details><summary>Answer</summary>
   Amazon Comprehend
   </details>

6. **Which service extracts text from scanned documents?**
   <details><summary>Answer</summary>
   Amazon Textract
   </details>

7. **Which service builds custom ML models?**
   <details><summary>Answer</summary>
   Amazon SageMaker
   </details>

8. **Which service provides intelligent document search?**
   <details><summary>Answer</summary>
   Amazon Kendra
   </details>

### Other Services

9. **Which service provides virtual desktops?**
   <details><summary>Answer</summary>
   Amazon WorkSpaces
   </details>

10. **Which service creates a cloud contact center?**
    <details><summary>Answer</summary>
    Amazon Connect
    </details>

---

## 📝 Flashcard Quick Reference

| Front | Back |
|-------|------|
| Rekognition | Image/video analysis, face detection |
| Transcribe | Speech-to-text |
| Polly | Text-to-speech |
| Translate | Language translation |
| Lex | Chatbots (Alexa) |
| Comprehend | NLP, sentiment analysis |
| SageMaker | Build/train custom ML |
| Kendra | Enterprise document search |
| Personalize | Product recommendations |
| Textract | OCR, extract from documents |
| Amazon Q | Gen AI assistant |
| WorkSpaces | Virtual desktops |
| Connect | Cloud contact center |
| IoT Core | Manage IoT devices |

---

## 💡 Tips & Tricks

### Exam Day Mnemonics

| Keyword | Think → Service |
|---------|-----------------|
| "Face detection" | Rekognition |
| "Chatbot" | Lex |
| "Speech to text" | Transcribe |
| "Text to speech" | Polly |
| "Sentiment" | Comprehend |
| "Scan PDF" | Textract |
| "Custom ML" | SageMaker |
| "Search documents" | Kendra |
| "Recommendations" | Personalize |
| "Virtual desktop" | WorkSpaces |
| "Call center" | Connect |

### Common Confusions

| Confusion | Clarification |
|-----------|---------------|
| Transcribe vs Polly | Transcribe = STT; Polly = TTS |
| Textract vs Comprehend | Textract = OCR; Comprehend = NLP |
| Kendra vs OpenSearch | Kendra = intelligent; OpenSearch = raw search |
| SageMaker vs others | SageMaker = custom ML; others = pre-built |

---

## ✅ Day 7 Completion Checklist

Before exam day, make sure you can:

- [ ] **Identify** all 10 ML services and their purposes
- [ ] **Match** ML keywords to services (sentiment → Comprehend)
- [ ] **Complete** a practice exam with 75%+ score
- [ ] **Review** all wrong answers and understand why
- [ ] **Identify** your 2-3 weakest domains
- [ ] **Know** additional services (WorkSpaces, Connect, IoT)

---

## 📊 Domain Review Quick Reference

### If Weak in Domain 1: Cloud Concepts (24%)

Review:
- 6 Cloud Advantages (trade CapEx for OpEx, economies of scale, etc.)
- AWS Well-Architected Framework (6 pillars)
- Cloud Adoption Framework (CAF) - 6 perspectives

### If Weak in Domain 2: Security (30%)

Review:
- Shared Responsibility Model (OF vs IN)
- IAM (Users, Groups, Roles, Policies)
- Security Groups vs NACLs
- Encryption (KMS, CloudHSM)

### If Weak in Domain 3: Technology (34%)

Review:
- EC2 pricing models (On-Demand, Reserved, Spot)
- S3 storage classes
- Database selection (RDS vs DynamoDB)
- Lambda limits and triggers

### If Weak in Domain 4: Billing (12%)

Review:
- Support Plans table (response times!)
- Cost management tools (Budgets vs Cost Explorer)
- AWS Organizations

---

## 📝 Quiz Guidance

**Practice Exams to Take:**

| Source | Notes |
|--------|-------|
| **Stephane Maarek Course** | Section 22 - Official practice exam |
| **AWS Skill Builder** | Free official practice questions |
| **Tutorials Dojo** | Excellent, exam-like questions |

**Target Score:** 80%+ before real exam

> [!TIP]
> Take 2-3 practice exams from different sources. Each has slightly different question styles.

---

**Previous:** [← Day 6 - Integration & Billing](day-06-integration-billing.md)  
**Next:** [Exam Day - Good Luck! 🎉]
