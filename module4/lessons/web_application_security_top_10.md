---
layout: page
title: OWASP's Top 10 Most Critical Web Application Security Risks
---

## Structure

|-|-|
| 5 | Warmup |
| 10 | Intro & OWASP |
| 20 | Research & Presentation Prep |
| 5 | Pomodoro |
| 50 | Presentations |

## Learning Goals

* Students are familiar with common security risks, examples and steps to begin prevention

## Warm Up

* What do you already know about web application security?
* Think back to Mod 3, what is Privilege Escalation?
* What about Mass Assignment Vulnerability?

## Intro

We've shown you best practices for security in Rails (authorization, authentication, strong params, etc), but Rails is not the only game in town. Let's talk about some of these concepts in general, and how they may apply in the various applications you build, and enable you to speak about these concepts from an educated perspective.

## OWASP

*OWASP* is a international not-for-profit organization focused on the improvement of software security. It is not affiliated with any particular company, instead is made up of mostly volunteers including security experts from around the world. This allows for unbiased and cost-effective information for anyone interested in improving application security.

About every 4 years the organization puts out a call for data to determine the current top 10 security risks. *OWASP* then puts out a survey to its members (*this could be you!*) to complete in order to rank the risks based on the following risk factors:
* Exploitability
* Weakness Prevalence
* Weakness Detectability
* Technical Impacts

Here is a list of the Top 10 security risks as chosen in 2017. For more details on each of the risks check out [OWASP Top 10 - 2017](https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf).

1. Injection
2. Broken Authentication
3. Sensitive Data Exposure
4. XML External Entities (XXE)
5. Broken Access Control
6. Security Misconfiguration
7. Cross-Site Scripting (XSS)
8. Insecure Deserialization
9. Using Components with Known Vulnerabilities
10. Insufficient Logging & Monitoring

For each vulnerability, the document describes how to determine if you application is vulnerable, example attack scenarios, as well as ways to prevent it.

## Research & Presentations

Alone or with a partner, describe you assigned vulnerability. Figure out what is important and describe it on your chart paper.
