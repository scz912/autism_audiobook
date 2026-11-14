# Presentation Script: Audiobook for Autism, Visual Playlist

Academic Project II progress presentation. Soh Chang Zheng (23004994). Supervisor: Dr. Nazean Jomhari.

About 1994 words, roughly 15 minutes at a calm speaking pace (about 135 words per minute). The same script is in each slide's speaker notes.

## Slide 1: Title  _(about 33 s)_

Good morning, Dr. Nazean and panel members. I am Soh Chang Zheng, and this is my Academic Project II progress presentation for Audiobook for Autism, the Visual Playlist sub-project.

My teammate Tiew Yi Xu works on the music side of the same system. Today I will cover my progress on the objectives, the requirements, the methodology, the system I have built, the testing so far, and how I have responded to the AP1 panel comments.

## Slide 2: Progress at a Glance  _(about 50 s)_

Here is the summary. Since the AP1 prototype in June, I have made 20 commits and added about 13,000 lines of code.

I group the work into three parts. Built: the biggest change is the caregiver community hub, with invite codes, friends, direct and group chat, a hub feed and book sharing. I also added private-by-default books, personal accounts with onboarding, the Paige guided tours and an iOS build.

Refined: I fixed the AI story generation, and reworked insights, upload, content management and the storybook player.

Evaluated: I have written 21 backend and 17 frontend automated tests.

So my modules are nearly complete. What remains is mainly performance measurement and user testing.

## Slide 3: Project Objectives: Progress  _(about 51 s)_

These are my three objectives from the AP1 report.

Objective one, identifying autism-friendly audio and visual design principles through a literature review and an online survey, is done.

Objective two, analysing existing audiobook and AI audio apps to find design gaps, is also done.

Objective three is in progress. After the panel comments, I widened it. It now includes caregiver-managed personalisation and a caregiver community for safe sharing, and it now includes an evaluation.

Both panels asked how I would prove effectiveness. Effectiveness is hard to prove within the FYP timeline, so I reworded it to usability and acceptance. I will measure this with the SUS questionnaire for caregivers and task completion for children.

## Slide 4: Functional Requirements: Progress  _(about 52 s)_

This table shows the original functional requirements, FR1 to FR20, and the evidence for each one in the latest build.

Login uses a 4-digit PIN hashed with bcrypt, and a Guardian PIN protects entry to and exit from Child Mode. Each child profile has its own voice, speed, volume, text size, auto-play and read-along settings.

Caregivers can upload audio or text, or generate a Gemini story with pictures, which they review before a child sees it. Playback covers pre-recorded audio and TTS, with fades, a volume ceiling and read-along highlighting.

Listening history, the insights report and the AI suggestions are working, and each caregiver only sees their own data.

All of these original requirements are now done.

## Slide 5: Non-Functional Requirements: Measurable  _(about 59 s)_

Panel 1 said my NFRs must be testable and measurable. So each NFR now has a number and a way to check it.

For usability, a child screen has at most five controls, and a caregiver can create a profile and assign a book in three steps or fewer. For accessibility, touch targets are at least 48 by 48 dp, and text size can go from 70 to 200 percent.

For sensory safety, audio fades in over at least 300 milliseconds, and the volume never jumps above the ceiling. For performance, playback must start in under 2 seconds, and speed or volume changes must apply in under 250 milliseconds. These are still to be timed on a phone.

I also added a new NFR for community privacy, covered by 10 PHPUnit visibility tests.

## Slide 6: New Requirements: Community Hub (M13)  _(about 54 s)_

Both panels said the scope was too small, and suggested features like inviting friends, choosing whether to share, and community features for caregivers. This slide shows the new requirements I wrote for that, as module M13.

FR40 lets a caregiver join the community and invite another family with an invite code. FR41 covers searching for members and handling friend requests. FR42 is one-to-one and group chat, where a message can carry an audiobook. FR43 is the members-only hub feed with likes, reactions and comments. FR44 lets a member save a private copy of a shared book. FR45, built by Yi Xu, covers favourite, mute and block.

Each requirement has an acceptance check on the right, so it can be tested directly.

## Slide 7: New Requirements: Accounts and Guide (M14, M15)  _(about 47 s)_

This slide continues the new requirements.

FR46 adds two account types at sign-up: a caregiver account with child profiles, and an independent account for a teenager. FR47 gives every new account its own copy of six starter audiobooks, so the library is never empty. FR48 and FR49 cover Paige, our mascot, who gives a first-run tour and moves to the next step when the user actually does the action.

At the bottom is the traceability for every module added after AP1. The green ones are mine: the community hub, personal accounts and the Paige guide. The others are Yi Xu's music, interactive book and Al-Quran modules.

## Slide 8: Methodology in Practice: Two-Week Sprints  _(about 48 s)_

Panel 1 said I did not explain the sprint length or the timeframe. I am still using Agile, now run as two-week sprints, and the dates follow the commit history.

Sprint 1 built the core community hub and fixed AI generation. Sprint 2 added private-by-default books. Sprint 3, which is now in progress, covers personal accounts, onboarding, the Paige tours and the iOS build.

Sprint 4 is for timing the performance targets and running the SUS questionnaire and the sessions with children. Sprint 5 is for fixes from feedback, the updated diagrams, the report and the demo.

Every sprint goes through plan, build, test, review and refine.

## Slide 9: How the AI Is Integrated  _(about 65 s)_

Panel 2 asked for a clear technical explanation of the AI. In the Laravel backend, a GeminiService class calls three Gemini models through REST.

The first pipeline makes an audiobook. The caregiver types a topic or pastes text. gemini-2.5-flash returns JSON in a fixed schema, with a title and four to six pages, each with text and an image prompt. gemini-2.5-flash-image draws one picture per page, shrunk to a 768-pixel JPEG. Gemini TTS narrates each page, and the audio is cached by a SHA-1 hash of the voice and text, so it is never generated twice. The caregiver then reviews and edits the story before it reaches the child.

The second pipeline is listening insights. Only anonymised totals and rates are sent, with no names or child details. Gemini can suggest up to three setting changes from six allowed settings, and nothing changes until the caregiver accepts.

## Slide 10: Community Hub: How Sharing Stays Safe  _(about 57 s)_

Sharing between families needs to be safe, so three rules on the Audiobook model decide who can see, open and change a book.

visibleTo decides my library: my own books plus the built-in starter books. New books are always private, so nothing I make appears for anyone else until I share it.

openableBy decides what I can play: my library plus books shared in the hub or my chats, but only after I have joined the community.

editableBy decides what I can change: only my own books. If I want to change a shared book, I save my own private copy first.

Every hub and chat request checks membership first, and blocked people never appear in search. This is covered by 10 visibility tests and 5 friend-request tests.

## Slide 11: System Modules: Original and New  _(about 49 s)_

On the left are the seven original modules from AP1, and all of them are now built. I own personalisation settings, content management and upload, and listening insights. Some, like the AI module and the playback engine, are shared with Yi Xu.

On the right are the new modules after AP1. Mine are the community hub, book visibility and save-a-copy, personal accounts and onboarding, and the Paige guided tours. Yi Xu owns the music modules, the community add-ons for favourite, mute and block, and the starter library.

So my sub-project now owns the social and sharing side of the system. This is how I widened the scope, as both panels asked.

## Slide 12: System Development: Community Hub  _(about 56 s)_

Now some screens from the latest build, using test accounts.

Figure 4 is the hub feed. A caregiver has shared a badminton story they made for their child, and other members have liked it, reacted and commented. Anyone can tap Listen to play the book.

Figure 5 is the Friends tab. At the top are two incoming friend requests that can be accepted or declined, and below is the friends list.

Figure 6 is a direct chat. A friend has shared a book inside a message, and I can save it to my own library with one tap. The book I shared back is marked as already in my library.

The key point is that nothing is shared unless the caregiver chooses to share it.

## Slide 13: System Development: Library, Insights and Guide  _(about 50 s)_

Figure 7 is the caregiver's library in content management. Each book here is private to this caregiver, and the list can be searched and filtered by type and language.

Figure 8 is the insights page with AI suggestions for one child. Here the AI suggests lowering the reading speed from 1.00 to 0.85, because the child pauses about three times per story. The caregiver can apply it, edit the value or skip it.

Figure 9 is the Paige guided tour. Paige highlights each tab in turn, here the Community tab, and explains it in one short sentence.

So caregivers stay in control of every change, and Paige shows new users where to tap.

## Slide 14: Testing and Evaluation: Activities  _(about 40 s)_

For testing, the automated tests for my features are written.

On the backend, there are 21 PHPUnit tests: 10 for book visibility, 5 for friend request answers, 3 for personal accounts, 2 for the narrator voice and 1 for music order.

On the frontend, there are 17 Flutter tests, covering the Paige guide, the welcome page, the Guardian PIN dialog, the child guide and the read-along words.

Still to do are the performance checks for NFR7 to NFR9, the caregiver usability test with SUS, and guided sessions with children.

## Slide 15: Evaluation Plan: Usability and Acceptance  _(about 53 s)_

This is how I will evaluate usability and acceptance, which replaces effectiveness.

For caregivers, the target is a SUS score of 68 or more, which is above the SUS average. They will answer it after four set tasks, including sharing a book to the hub and saving a copy.

For children, the target is 80 percent or more of tasks finished, in short guided sessions with a caregiver present. Any signs of discomfort will be noted on a checklist.

For the system, playback should start in under 2 seconds and changes should apply in under 250 milliseconds, timed 10 times each on a mid-range Android phone.

Participants will come through Dr. Nazean's network, with caregiver consent before any session.

## Slide 16: Addressing AP1 Feedback: Panel 1  _(about 46 s)_

Next, the actions I took on Dr. Chiam's comments.

The scope was too small, so I added the community hub with invites, friends, chat, the feed, save-a-copy and block, and books are private by default. The NFRs are now measurable, and every new FR has an acceptance check. Objective 3 is reworded to usability and acceptance. The sprint length and dates are explained on slide 8.

Testing with children is planned for Sprint 4.

Copyright is in progress. Stories and pictures are AI-generated, uploads stay private to the uploader unless shared, and I am recording the licence of each content source in the report.

## Slide 17: Addressing AP1 Feedback: Panel 2  _(about 43 s)_

And these are the actions on Dr. Nasuha's comments.

For proving effectiveness, the objective now says usability and acceptance, with measurable targets. For the small scope, I added the community hub for caregivers. Every figure and table in this deck is now numbered and labelled. The technical AI explanation is on slide 9.

One item is still in progress. The panel said the diagrams must match the requirements and the FRs were too limited. FR28 to FR49 now cover all eight new modules, and I am updating the use case, class, sequence and ER diagrams to match.

## Slide 18: Next Steps for AP2  _(about 34 s)_

To finish, development is nearly complete, and the remaining work is mostly measurement and user testing.

First, time NFR7 to NFR9 on a mid-range Android phone. Second, run the SUS questionnaire with caregivers and the guided sessions with children. Third, update the use case, class, sequence and ER diagrams for FR40 to FR49. Fourth, write up the results, settle the copyright notes and record the final demo.

Thank you. I am happy to take any questions.
