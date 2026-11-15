# New modules M8 to M17

These are the ten modules added after AP1, with functional requirements
FR28 to FR61. M1 to M7 and FR1 to FR27 from the AP1 report are not repeated
here. Each requirement has an acceptance check so it can be tested.

## M8 Music intelligence

| ID | Requirement | Acceptance check |
|---|---|---|
| FR28 | The system shall let a caregiver upload their own music (MP3, MP4, WAV and other common formats), convert it to MP3, and keep it private to that caregiver. | Upload a WAV and an MP4 file; both play as MP3 in the picker, and a second account cannot see them. |
| FR29 | The system shall measure each track's tempo (BPM), beat steadiness, loudness swing and any sudden jump of 10 dB or more, and flag tracks that may be a sensory risk. | Analyse a calm track and a track with a sudden loud jump; only the second is flagged. |
| FR30 | The system shall use Gemini to listen to each track twice and keep a genre only when both listens agree, otherwise mark it unsure. Emotion tags and sensory notes shall be stored with the track. | Tag a labelled track; the stored genre matches both listens, or the track is marked unsure when they disagree. |

## M9 Music taste and recommendations

| ID | Requirement | Acceptance check |
|---|---|---|
| FR31 | The system shall, with permission, count the genres of songs played on YouTube and YouTube Music, keeping only the genre counts on the phone. | Allow access and play songs; only genre counts are stored, on the phone. Without permission, nothing is read. |
| FR32 | The system shall turn the listener's music taste into a score for each background-music genre and pass it to the book recommender (M17), so audiobooks whose music suits the listener rank higher. | With access allowed, a book whose music matches the top genre ranks higher. Without access, recommendations still appear. |

## M10 Piano composer

| ID | Requirement | Acceptance check |
|---|---|---|
| FR33 | The system shall provide an in-app C major piano that records a melody and saves it as an MP3 file, ready to use as background music. | Record a short melody and save it; the MP3 plays back and can be chosen as background music. |

## M11 Interactive branching audiobooks

| ID | Requirement | Acceptance check |
|---|---|---|
| FR34 | The system shall allow a caregiver to create an interactive audiobook in which a page can ask a question with 2 to 4 answer choices. | Create a book with a question page; saving is refused with fewer than 2 or more than 4 choices. |
| FR35 | The system shall support two kinds of answer page after a question: a shared page that reads the child's chosen answer in place of {choice}, and a split question with a separate page for each of its 2 choices, after which the story joins back. | Play both kinds; the shared page speaks the chosen answer, and each split choice opens its own page before the story continues. |
| FR36 | The system shall let the child answer a question by tapping a choice during playback, and continue the story along that choice. | In Child Mode, tap each choice in turn; the next page always matches the choice tapped. |

## M12 Al-Quran audio pack

| ID | Requirement | Acceptance check |
|---|---|---|
| FR37 | The system shall let a caregiver download and remove individual Al-Quran chapters, showing the storage size of each chapter and of downloading all of them. | Download one chapter, check the size shown, remove it and confirm the space is freed. |
| FR38 | The system shall play a downloaded chapter without internet, one page per verse, turning the page as each verse is recited and jumping the recitation when the child swipes to another verse. | With the phone offline, play a chapter; pages follow the recitation and a swipe moves the audio to that verse. |
| FR39 | The system shall show the sources and licences of the recitation audio and images used in the pack. | Open the Al-Quran tab; the sources and licences are listed at the end. |

## M13 Community hub

| ID | Requirement | Acceptance check |
|---|---|---|
| FR40 | The system shall let a caregiver choose to join the community, and invite another family with a shareable invite code. Only signed-in members can see community content. | Join, create a code, redeem it on a second account; the two become friends. Signed-out requests to the feed are refused. |
| FR41 | The system shall let members search for other members, send, accept or decline friend requests, and remove friends. | Run each action between two test accounts and check both friend lists. |
| FR42 | The system shall let members chat one-to-one with a friend or in a group, sending text, an audiobook or both, and show the number of unread messages. | Send each message type in a direct and a group chat; the unread count rises and clears when the chat is opened. |
| FR43 | The system shall let members share an audiobook, text or both to a members-only feed, and like, react to and comment on posts. Members can delete their own posts and comments. | Post each type, react and comment from a second account, then delete them as the author. |
| FR44 | The system shall let a member save a private copy of an audiobook shared in the feed or a chat into their own library. | Save a shared book; it appears in the library, and editing the copy leaves the original unchanged. |
| FR45 | The system shall let members mark another member as a favourite, mute them or block them. Favourite chats are pinned on top, muted chats show no unread alert, and a blocked member can no longer message them and their posts are hidden. | Set each flag on a test account and check the chat list, the unread dot, messaging and the feed. |

## M14 Personal accounts and starter library

| ID | Requirement | Acceptance check |
|---|---|---|
| FR46 | The system shall offer two account types at sign-up: a caregiver account with child profiles and Child Mode, and an independent account for a teenager who uses the app alone, with all features in one taskbar and no Child Mode. | Register one of each; the independent account opens straight to its own taskbar with no PIN switch. |
| FR47 | The system shall give every new account its own copy of six starter audiobooks (three normal, three interactive), so the library is never empty. | Register a new account; six books are in the library, and deleting one does not affect other accounts. |

## M15 Interactive guide

| ID | Requirement | Acceptance check |
|---|---|---|
| FR48 | The system shall show a first-run tour led by the Paige mascot for each account type (caregiver, child, independent) and on the upload screen, pointing out each part of the screen. | Sign in with a fresh account of each type; the tour starts once and highlights each tab. |
| FR49 | The system shall move hands-on tour steps on by themselves when the user does the action (for example picking a mood, playing a note or recording), and let the user skip the tour or replay it later. | During the child tour, pick a mood and play a note; each step advances without tapping Next. Skip, then replay from the mascot. |

## M16 AI adaptive settings (smart tips)

| ID | Requirement | Acceptance check |
|---|---|---|
| FR50 | The system shall record, for each listening session, the pages reached, the times the child went back a page, pauses, Next taps, and any reading speed, text size or narrator voice the child changed during the book. | Read a book, go back one page and change the speed; the saved session shows the back count and the new speed. |
| FR51 | The system shall find setting tips with rules over the child's last 30 days of listening, counting recent sessions more (7-day half-life), and give each tip a strength and a short reason in English and Malay. | Unit tests: lots of going back and pausing gives a slower reading speed tip, and a child who keeps making the words bigger gets a text size tip. |
| FR52 | The system shall learn which kinds of tips work, for each child and across all families, from the caregiver's choice (apply, edit or skip) and from whether listening got better after 3 more sessions, and rank the tips by it (Thompson sampling). | Skip one kind of tip several times; it stops appearing. Apply a tip and add 3 better sessions; it is counted as helped. |
| FR53 | The system shall send the ranked shortlist to Gemini, which picks at most 3 tips and rewrites their reasons in simple words. Only listening numbers, current settings and the child's age are sent, never names. | With Gemini on, at most 3 tips are shown with simple reasons. |
| FR54 | The system shall not let Gemini add tips or change suggested values, and shall still show the learned tips when Gemini is off or fails. | Turn Gemini off; tips still appear in the learned order. A tip id that Gemini makes up is ignored. |
| FR55 | The system shall let the caregiver apply, edit or skip each tip, and show each tip's reason and how often that kind of tip helped before. No setting shall change without the caregiver's action. | Skip a tip; the child's settings stay the same. Apply one; only that setting changes. Each tip shows its reason and a "helped" count. |

## M17 Book recommendations

| ID | Requirement | Acceptance check |
|---|---|---|
| FR56 | The system shall rate each book a child has read from how it was read in the last 90 days: finished counts as liked, stopping early as not liked, and re-reading as a strong like. | Finish one book and stop another early; the first is rated higher. |
| FR57 | The system shall suggest books similar to the ones the child liked, by category, topic, tags, level, language and background music (content-based filtering with TF-IDF). | Unit test: a child who likes one topic gets another book on that topic first, and books like ones they stopped early rank lower. |
| FR58 | The system shall suggest books that children with the same taste liked (item-item collaborative filtering), using listening from all families without showing other children's details. | Unit test: when two children who read book A also liked book B, a child who liked A gets B suggested. |
| FR59 | The system shall give a new child with no history popular books that fit today's mood, and rely more on the child's own taste as their history grows. | A new child's list is not empty and its picks fit the chosen mood. |
| FR60 | The system shall adjust picks for today's mood, a difficulty just right for the child, their age and, if allowed, their music taste (FR32). It shall keep the list varied (MMR), move books just finished down, and leave out books still being made. | Finish a book; it moves down the list. The top 3 are not all the same kind. Unit tests for mood, difficulty and music taste pass. |
| FR61 | The system shall recommend only from the family's own library and only for their own children, and show one short reason with each pick, on the Insights page and as Today's pick on the child's home. | Each pick shows a reason. Asking for another family's child is refused. |

## Traceability

| Module | Requirements | Built by |
|---|---|---|
| M8 Music intelligence | FR28, FR29, FR30 | Tiew Yi Xu |
| M9 Music taste and recommendations | FR31, FR32 | Tiew Yi Xu |
| M10 Piano composer | FR33 | Tiew Yi Xu |
| M11 Interactive branching audiobooks | FR34 to FR36 | Tiew Yi Xu |
| M12 Al-Quran audio pack | FR37 to FR39 | Tiew Yi Xu |
| M13 Community hub | FR40 to FR44 / FR45 | Soh Chang Zheng / Tiew Yi Xu |
| M14 Personal accounts and starter library | FR46 / FR47 | Soh Chang Zheng / Tiew Yi Xu |
| M15 Interactive guide | FR48, FR49 | Soh Chang Zheng |
| M16 AI adaptive settings (smart tips) | FR50 to FR55 | Soh Chang Zheng |
| M17 Book recommendations | FR56 to FR61 | Soh Chang Zheng |
