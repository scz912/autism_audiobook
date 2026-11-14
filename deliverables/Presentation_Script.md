# Presentation Script: Audiobook for Autism, Visual Playlist

AP2 progress presentation. Soh Chang Zheng (23004994). Supervisor: Dr. Nazean Jomhari.

About 944 words, roughly 7 minutes. The same script is in each slide's speaker notes.

## Slide 1: Title  _(about 19 s)_

Good morning, Dr. Nazean and panel members. My name is Soh Chang Zheng. This is my AP2 progress presentation for Audiobook for Autism, the Visual Playlist part.

My teammate, Tiew Yi Xu, works on the music part of the same app.

## Slide 2: Progress at a Glance  _(about 30 s)_

Here is a quick summary. Since AP1, I made 20 commits and about 13,000 lines of code.

The biggest new part is the community hub, where caregivers can add friends, chat and share books. I also fixed the AI story making and improved other screens.

I have written 38 automated tests. My modules are almost done. The main work left is testing with real users.

## Slide 3: Project Objectives: Progress  _(about 28 s)_

These are my three objectives.

Objectives one and two are done. Objective three is in progress.

After the panel comments, I changed one word in objective three. It said effectiveness. Effectiveness is hard to prove in our time, so now it says usability and acceptance. I will measure it with the SUS questionnaire for caregivers, and task completion for children.

## Slide 4: Functional Requirements: Progress  _(about 21 s)_

This table shows my original requirements, FR1 to FR20.

All of them are now built. This includes PIN login, child profiles with their own settings, uploading or making books with AI, the story player, and the insights page.

Each family can only see its own data.

## Slide 5: Non-Functional Requirements: Measurable  _(about 28 s)_

Panel 1 said my NFRs must be measurable. So now each NFR has a number and a test.

For example, a child screen has at most five buttons. Buttons are at least 48 by 48 dp. Playback must start in under 2 seconds.

Some are done. The speed targets will be timed on an Android phone in the next sprint.

## Slide 6: New Requirements: Community Hub (M13)  _(about 32 s)_

Both panels said my scope was too small. They suggested inviting friends and sharing between caregivers. So I added the community hub.

Caregivers can join and invite other families with a code. They can add friends, chat, and send a book in a message. They can share books to a feed, and save their own copy of a shared book.

Each requirement has a simple test on the right.

## Slide 7: New Requirements: Accounts and Guide (M14, M15)  _(about 25 s)_

I also added three more features.

First, two account types: one for caregivers, and one for teenagers who use the app by themselves. Second, every new account gets six starter books. Third, Paige, our mascot, gives a short tour the first time you sign in.

At the bottom, the green boxes are my modules.

## Slide 8: Methodology in Practice: Two-Week Sprints  _(about 20 s)_

Panel 1 asked about my sprint length. I use Agile with two-week sprints.

Sprints 1 and 2 are done. Sprint 3 is in progress now. Sprint 4 is for testing with users, and Sprint 5 is for fixes, the report and the demo.

## Slide 9: How the AI Is Integrated  _(about 36 s)_

Panel 2 asked how the AI works. Our backend calls three Gemini models.

To make a book, the caregiver types a topic. The first model writes the story. The second model draws a picture for each page. The third model reads each page aloud. Then the caregiver checks the story before the child sees it.

For insights, we only send numbers like minutes and pauses, never names. The AI suggests up to three setting changes, and the caregiver decides.

## Slide 10: Community Hub: How Sharing Stays Safe  _(about 29 s)_

Sharing must be safe, so three rules decide who can see, play and change a book.

New books are always private. I can play books that friends share with me, but only after I join the community. And I can only change my own books. If I like a shared book, I save my own copy.

These rules are covered by 15 tests.

## Slide 11: System Modules: Original and New  _(about 21 s)_

All seven original modules are built. We also added eight new modules.

The ones marked Mine are my work, like the community hub, accounts and the Paige tours. Yi Xu built the music modules.

So my part now covers sharing and community, as both panels asked.

## Slide 12: System Development: Community Hub  _(about 29 s)_

Here are some screens from the app, using test accounts.

Figure 4 is the hub feed, where a parent shares a story. Figure 5 is the Friends tab, with friend requests at the top. Figure 6 is a chat, where a friend sends a book and I can save it to my library.

Nothing is shared unless the caregiver chooses to share it.

## Slide 13: System Development: Library, Insights and Guide  _(about 21 s)_

Figure 7 is the library. Each book here is private.

Figure 8 shows AI tips. Here the AI suggests a slower reading speed, because the child pauses often. The caregiver can apply, edit or skip it.

Figure 9 is Paige's tour, showing the Community tab.

## Slide 14: Testing and Evaluation: Activities  _(about 14 s)_

For testing, I have written 21 backend tests and 17 frontend tests.

Next, I will time the app's speed, test it with caregivers using SUS, and run short sessions with children.

## Slide 15: Evaluation Plan: Usability and Acceptance  _(about 18 s)_

These are my targets.

For caregivers, a SUS score of 68 or more. For children, at least 80 percent of tasks finished. For the system, start in under 2 seconds.

Participants will come from Dr. Nazean's network, with caregiver consent.

## Slide 16: Addressing AP1 Feedback: Panel 1  _(about 27 s)_

This is how I answered Dr. Chiam's comments.

I added the community hub to grow the scope. My NFRs now have numbers. Objective three now says usability and acceptance. Sprints are explained on slide 8.

Two items are not done yet. Testing with children is planned. Copyright is in progress, and I am listing all sources in the report.

## Slide 17: Addressing AP1 Feedback: Panel 2  _(about 21 s)_

And this is how I answered Dr. Nasuha's comments.

I changed effectiveness to usability and acceptance. I added the community hub. All figures and tables now have labels. And slide 9 explains the AI.

The diagrams are still being updated to match the new requirements.

## Slide 18: Next Steps for AP2  _(about 16 s)_

To finish, the app is almost done. Next, I will time the app, test it with caregivers and children, update the diagrams, and write the report.

Thank you. I am happy to take your questions.
