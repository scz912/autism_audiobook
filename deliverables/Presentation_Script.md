# Presentation Script: Audiobook for Autism, Visual Playlist

AP2 progress presentation. Soh Chang Zheng (23004994). Supervisor: Dr. Nazean Jomhari.

About 602 words, roughly 5 minutes. The same script is in each slide's speaker notes.

## Slide 1: Title  _(about 17 s)_

Good morning, Dr. Nazean and panel members. I am Soh Chang Zheng, and this is my AP2 progress for Audiobook for Autism, the Visual Playlist part. My teammate, Tiew Yi Xu, works on the music part.

## Slide 2: Progress at a Glance  _(about 16 s)_

Since AP1, I added three big parts: a community hub, AI smart tips, and book recommendations.

I have written 69 automated tests. My modules are almost done. The main work left is user testing.

## Slide 3: Project Objectives: Progress  _(about 18 s)_

Objectives one and two are done. Objective three is in progress.

I changed effectiveness to usability and acceptance, because effectiveness is hard to prove in our time. I will measure it with SUS for caregivers and task completion for children.

## Slide 4: Functional Requirements: Progress  _(about 5 s)_

All my original requirements, FR1 to FR20, are now built.

## Slide 5: Non-Functional Requirements: Measurable  _(about 13 s)_

Each NFR now has a number and a test. For example, playback must start in under 2 seconds. The speed targets will be timed in the next sprint.

## Slide 6: New Requirements: Community Hub (M13)  _(about 12 s)_

Both panels said my scope was too small, so I added the community hub, module M10. Caregivers can invite families, add friends, chat, and share books.

## Slide 7: New Requirements: AI Adaptive Settings (M12)  _(about 22 s)_

Panel 1 said most of the AI was done by my teammate. So I built two AI modules of my own. The first is M12, AI adaptive settings, which we call smart tips. It suggests better settings for each child, and nothing changes until the caregiver says yes.

## Slide 8: New Requirements: Book Recommendations (M13)  _(about 10 s)_

The second is M13, book recommendations. It picks the next book for each child, and every pick shows a short reason.

## Slide 9: Methodology in Practice: Two-Week Sprints  _(about 13 s)_

I use Agile with two-week sprints. Sprints 1 and 2 are done, Sprint 3 is in progress, and Sprints 4 and 5 are for user testing and the report.

## Slide 10: How My AI Part Works: Smart Tips  _(about 24 s)_

Smart tips work in three steps. First, rules look at how the child reads, like going back or pausing. Second, the app learns which tips helped before. Third, Gemini picks the best three and words them simply.

Gemini cannot add tips or change values, and the app still works without it.

## Slide 11: How the Book Recommender Works  _(about 22 s)_

The recommender only uses our own listening data. A finished book counts as liked. Then it finds similar books, and books that children with the same taste liked. It also uses today's mood and the right level.

The final list is varied, and each pick says why.

## Slide 12: Community Hub: How Sharing Stays Safe  _(about 10 s)_

Sharing is safe. New books are private, only members can see shared books, and I can only change my own books.

## Slide 13: System Modules: Original and New  _(about 14 s)_

All seven original modules are built, plus six new ones. Yi Xu has three and I have three: the community hub, M10, and my two AI modules, M12 and M13.

## Slide 14: System Development: Community Hub  _(about 10 s)_

Here are screens from the app with test accounts: the hub feed, the Friends tab, and a chat with a shared book.

## Slide 15: System Development: AI and Guide  _(about 12 s)_

Figure 8 shows book picks, each with a reason. Figure 9 shows smart tips that the caregiver can apply or skip. Figure 10 is Paige's tour.

## Slide 16: Testing and Evaluation: Activities  _(about 10 s)_

I have 52 backend tests and 17 frontend tests, and they all pass. Next is speed checks and testing with users.

## Slide 17: Evaluation Plan: Usability and Acceptance  _(about 11 s)_

My targets are a SUS score of 68 or more, 80 percent of tasks finished by children, and playback starting in under 2 seconds.

## Slide 18: Addressing AP1 Feedback: Panel 1  _(about 14 s)_

For Dr. Chiam's comments, I added the community hub and two AI parts, made the NFRs measurable, and explained the sprints. Testing with children and copyright are still in progress.

## Slide 19: Addressing AP1 Feedback: Panel 2  _(about 14 s)_

For Dr. Nasuha's comments, I changed the objective wording, added the hub, labelled all figures, and explained the AI on slides 10 and 11. The diagrams are still being updated.

## Slide 20: Next Steps for AP2  _(about 13 s)_

Next, I will time the app, test it with caregivers and children, update the diagrams, and write the report. Thank you. I am happy to take your questions.
