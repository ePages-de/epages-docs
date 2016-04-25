---
layout: post
title: "Guest post: A Shippo developer gives an insight on the technical integration into ePages"
date: "2015-06-21 23:59:25"
image: blog-header/puzzle.jpg
categories: tech-stories
authors: ["Shippo"]
---

Shippo is excited to support ePages merchants thanks to a new partnership.
ePages helps businesses set up their online shop via channel partners and offers them tools like Shippo to simplify the e-commerce experience.
This collaboration benefits the ePages channel partners because they need not build carrier shipping integrations themselves, trusting in companies like Shippo to provide the technology, service, and expertise in complicated markets like shipping.

By integrating Shippo with ePages stores, merchants will save time and money on their shipping.
They use Shippo’s simple, frictionless dashboard to create shipping labels in a few steps across 14 different shipping carriers.
Merchants track packages, send notification emails, print packing slips, and much more.

Here is insight into the technical aspect of this integration from one of our developers:

With this ePages integration, the need to refactor our abstraction layer for shop integrations became necessary.
We previously integrated with third-party e-commerce platforms using an interface that worked flawlessly.
However, the previous abstraction was susceptible to schema changes in the database, which, on occasion, meant a database migration.
We decided to design a more flexible layer to streamline our integrations and, at the same time, create an interface that is also independent of any common schema or data migrations.

The safest approach for this project was to *test - refactor - repeat*.
This process was tedious and extremely slow, but it guaranteed that existing shop integrations remained fully functional.
Digging into the existing design revealed some problems, which could have been avoided had we thought more deeply about the design requirements.
Fortunately, we addressed this before our technical debt started to pile up.

The biggest challenge during this process was to not repeat common functionality of the design, such as order update, validation, and serialisation.
This meant that changes to common methods would not require updating more than one piece of code, which translates to less maintenance and fewer bugs.
It also made obscure dependencies easier to spot and the code easier to debug.

The advantage from this change is tremendous: **we can integrate with third-party platforms much more rapidly.**
The actual ePages integration took roughly one week of development time, while the large majority was spent on refactoring the existing codebase.

Refactoring can usually be avoided, if all of the design requirements are taken into consideration.
If you expect some logic will become more complex, then it’s better to address it early on and not wait until the change is needed.
By then, a minor change to the codebase could cause it to break, or worse, it could introduce a bug to production.

This type of project is not usually influenced by customer feedback, however, thanks to all the real-time constructive criticism and suggestions, we were able to pinpoint and resolve some user experience difficulties during the integration process.
This included improving our order update process and preventing duplicate items/orders due to user error.
We’re now excited to bring Shippo to the ePages community! To learn more about Shippo, visit [goshippo.com](https://goshippo.com/).
