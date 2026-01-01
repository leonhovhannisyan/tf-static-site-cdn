# Terraform Static Site on AWS (S3 + CloudFront)

## Project summary
This project demonstrates a **production-style Terraform setup** for hosting a secure static website on AWS using **S3 (private)** and **CloudFront**, with modern best practices:

- Infrastructure defined fully as code (Terraform)
- Private S3 bucket (no public access)
- CloudFront distribution using **Origin Access Control (OAC)** instead of legacy OAI
- Strict S3 bucket policy allowing access **only from CloudFront**
- Separate environments (dev / prod)
- CI pipeline with formatting, validation, linting, and plan
- GitHub Actions authentication to AWS using **OIDC (no long-lived credentials)**

The goal of this repository is to showcase **real-world Terraform and DevOps practices** in a recruiter-friendly way, not just exam-level examples.

---

## Architecture overview
High-level flow:

```
User → CloudFront (HTTPS)
         ↓
     Private S3 bucket
```

- Users access the site via CloudFront
- CloudFront fetches content securely from S3 using OAC
- S3 bucket is not publicly accessible

---

## Live demo (dev environment)
**CloudFront URL:**

```
https://d23b56g0uketc9.cloudfront.net
```

---

## Repository structure
```
.
├── modules/
│   └── static_site/        # Reusable Terraform module (S3 + CloudFront + OAC)
├── envs/
│   ├── dev/                # Development environment
│   └── prod/               # Production environment
├── site/                   # Static website content
├── scripts/                # Deployment helper scripts
└── .github/workflows/      # GitHub Actions CI pipeline
```

---

## CI / CD
This repository uses **GitHub Actions** to enforce Terraform quality and safety:

- terraform fmt
- terraform validate
- tflint (AWS ruleset)
- terraform plan on pull requests (OIDC-based, no secrets)

---

## Screenshots
Github Actions CI green checks:
<img width="1260" height="535" alt="image" src="https://github.com/user-attachments/assets/91e6a575-c787-4320-8b6b-02e191ae3338" />

AWS CloudFront / site working screenshot:
<img width="696" height="194" alt="image" src="https://github.com/user-attachments/assets/0b84f956-1d96-44ec-8dd8-47c6d34c5aff" />

---

## How to use (dev)
```
cd envs/dev
terraform init
terraform apply
```

Deploy site content:
```
aws s3 sync ./site s3://${bucket-name}
```

Destroy when finished:
```
terraform destroy
```

---

## Notes
- No custom domain or Route53 is used to avoid fixed monthly costs
- Designed to be safe for AWS Free Tier / credit-based accounts
- Focused on clarity, security, and maintainability

---

## Why this project matters
This project reflects how Terraform is commonly used in real DevOps teams:
- modular design
- CI validation
- least-privilege access
- secure cloud patterns

It is intentionally **simple but correct**, prioritizing correctness over unnecessary complexity.
