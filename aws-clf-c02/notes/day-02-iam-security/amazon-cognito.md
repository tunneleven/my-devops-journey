# Amazon Cognito

> Amazon Cognito = AWS's "Login System as a Service" for your web & mobile apps

## What Cognito Handles

```
✅ User registration (sign-up)
✅ User login (sign-in)
✅ Password policies & reset
✅ Multi-Factor Authentication (MFA)
✅ "Login with Google/Facebook/Apple"
✅ Temporary AWS credentials for users
✅ User profile storage
✅ Device sync
```

---

## Two Main Components (Critical for Exam!)

```
┌─────────────────────────────────────────────────────────────┐
│                     AMAZON COGNITO                           │
│                                                             │
│   ┌─────────────────────┐   ┌─────────────────────┐        │
│   │    USER POOLS       │   │   IDENTITY POOLS    │        │
│   │   (Authentication)  │   │   (Authorization)   │        │
│   │                     │   │                     │        │
│   │  "Who are you?"     │   │  "What can you do?" │        │
│   └─────────────────────┘   └─────────────────────┘        │
└─────────────────────────────────────────────────────────────┘
```

---

## User Pools (Authentication)

**Purpose**: Manage user sign-up and sign-in

```
USER POOL = Your App's User Directory
┌────────────────────────────────────────────┐
│  Users:                                    │
│  ├── john@email.com (password, MFA)        │
│  ├── jane@email.com (password, MFA)        │
│  └── bob@email.com (via Google)            │
│                                            │
│  Features:                                 │
│  ├── Sign-up / Sign-in forms               │
│  ├── Password policies                     │
│  ├── Email/SMS verification               │
│  ├── MFA (TOTP, SMS)                       │
│  └── Social login (Google, Facebook, etc)  │
│                                            │
│  Output: JWT Tokens (ID, Access, Refresh)  │
└────────────────────────────────────────────┘
```

---

## Identity Pools (Authorization)

**Purpose**: Give authenticated users temporary AWS credentials

```
IDENTITY POOL = Exchange Tokens for AWS Access
┌────────────────────────────────────────────┐
│  Input:                                    │
│  └── JWT Token (from User Pool or Google)  │
│                                            │
│  Output:                                   │
│  └── Temporary AWS Credentials:            │
│      ├── AccessKeyId (temp)                │
│      ├── SecretAccessKey (temp)            │
│      └── SessionToken                      │
│                                            │
│  Now user can access:                      │
│  ├── Their S3 bucket                       │
│  ├── Their DynamoDB records               │
│  └── Any AWS service (based on IAM role)   │
└────────────────────────────────────────────┘
```

---

## Quick Comparison

| Aspect | User Pool | Identity Pool |
|--------|-----------|---------------|
| **Question** | "Who are you?" | "What can you access?" |
| **Function** | Authentication | Authorization |
| **Output** | JWT Tokens | Temporary AWS Credentials |
| **Manages** | Usernames, passwords, MFA | IAM Roles for users |
| **Standalone?** | ✅ Yes | ❌ Needs tokens |

---

## Social Identity Providers

Cognito makes "Login with Google" easy!

```
User clicks "Login with Google"
            │
            ▼
┌─────────────────────┐
│   Google Login      │ ← Google handles auth
└─────────────────────┘
            │ Google Token
            ▼
┌─────────────────────┐
│   Cognito User Pool │ ← Exchanges for Cognito JWT
└─────────────────────┘
            │ Cognito JWT
            ▼
┌─────────────────────┐
│   Your Application  │ ← App trusts Cognito JWT
└─────────────────────┘
```

**Supported:** Google, Facebook, Apple, Amazon, SAML 2.0, OIDC

---

## How User Pools & Identity Pools Work Together

```
Step 1: User logs in
App ──► User Pool ──► JWT Token

Step 2: Get AWS access
JWT Token ──► Identity Pool ──► Temp AWS Credentials

Step 3: Access AWS resources
App + Credentials ──► S3/DynamoDB
```

---

## Users Access AWS via App Only!

**Important**: Cognito users do NOT access AWS Console!

```
Cognito Identity Pool credentials:
├── ✅ Used INSIDE your app (via AWS SDK)
├── ✅ Access AWS services programmatically
│
├── ❌ NOT for AWS Console login
├── ❌ NOT for general AWS management
└── ❌ Users don't know they're using "AWS"
```

### Comparison

| Aspect | IAM User | Cognito User |
|--------|----------|--------------|
| **Console access** | ✅ Yes | ❌ No |
| **CLI access** | ✅ Yes | ❌ No |
| **App/SDK access** | ✅ Yes | ✅ Yes |
| **Credential type** | Long-term or temp | Always temporary |
| **Who uses it** | AWS admins | App customers |
| **Scale** | Hundreds | Millions |

---

## Real-World Example

**Instagram clone:**
```
User "John" opens app
       │
       ▼
1. Login with Google ──► Cognito User Pool
       │
       ▼
2. Get temp credentials ──► Cognito Identity Pool
       │
       ▼
3. Upload photo ──► S3 (via temp credentials)

John NEVER sees: AWS Console, Access keys, S3 bucket names
John only sees: App, Upload button, His photos
```

---

## Cognito vs IAM

| Aspect | Amazon Cognito | IAM |
|--------|----------------|-----|
| **For whom?** | App users (customers) | AWS administrators |
| **Scale** | Millions of users | Hundreds of users |
| **Identity source** | Sign-up, social login | AWS creates users |
| **Credentials** | Temporary (via STS) | Can be long-term |
| **Use case** | Mobile/web app | AWS management |

**Rule**: IAM = AWS admins, Cognito = App end users

---

## Common Use Cases

| Use Case | How Cognito Helps |
|----------|-------------------|
| Mobile app login | User Pool handles sign-up/sign-in |
| "Login with Google" | Federated identity via User Pool |
| User uploads to S3 | Identity Pool gives temp S3 access |
| Sync data across devices | Cognito Sync feature |
| Serverless app auth | API Gateway + Cognito authorizer |

---

## Exam Questions

**Q1**: Allow mobile app users to log in with Google?
> **Amazon Cognito User Pools** - supports federated identity.

**Q2**: How can app users upload to S3 without IAM users?
> **Cognito Identity Pools** - exchange tokens for temporary AWS credentials.

**Q3**: Difference between User Pools and Identity Pools?
> - User Pools = Authentication (who?) → JWT tokens
> - Identity Pools = Authorization (what?) → AWS credentials

**Q4**: Do Cognito users get long-term access keys?
> **NO!** Temporary credentials only. More secure.

---

## Summary

| Concept | Memory Hook |
|---------|-------------|
| **Cognito** | Login system for your apps |
| **User Pools** | Authentication (login/signup) |
| **Identity Pools** | AWS credentials for users |
| **Social Login** | Google/Facebook via User Pools |
| **vs IAM** | IAM = admins, Cognito = app users |
