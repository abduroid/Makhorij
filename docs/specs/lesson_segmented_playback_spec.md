# Lesson Segmented Audio Playback Spec
## 1. Goal

Enable segmented playback of example words within a lesson using a single pre-recorded audio file.

Each lesson teaches a single Arabic letter.
The lesson contains multiple example words.
Each word corresponds to a specific time range inside one shared audio file.

The feature must allow users to tap a word and hear only its corresponding audio segment.

This implementation is intentionally simple and optimized for the current lesson format.

## 2. Scope

One lesson is active at a time.

Each lesson uses a single audio file stored in assets.

Each lesson contains 10–15 example words.

Audio length is approximately 60–90 seconds.

Timestamps are manually defined.

## 3. Data Model

Each word is defined as:

class Word {
final String arabicText;
final int startSeconds;
final int endSeconds;
}

### Constraints:

startSeconds and endSeconds are manually curated.

Seconds are stored in the data layer.

Playback logic must convert seconds into Duration.

startSeconds < endSeconds must be assumed valid.

##  Functional Requirements
   ### 4.1 Single Playback Rule

Only one audio segment may play at any time.

If a new word is tapped:

Any active playback must stop immediately.

The new word must begin playback from its startSeconds.

Overlapping playback is strictly prohibited.

## 4.2 Restart Behavior

If the currently playing word is tapped again:

Playback must restart from its startSeconds.

Continuation from current position is not allowed.

## 4.3 Automatic Stop at Segment End

Playback must:

Seek to startSeconds.

Begin playback.

Automatically stop when position reaches or exceeds endSeconds.

Stopping must be driven by monitoring positionStream.

Timers must not be used for stopping logic.

Minor overshoot within silent pauses is acceptable.

## 4.4 Page Navigation Behavior

Swiping between pages within the lesson must stop active playback.

Navigating away from the lesson screen must stop active playback.

No audio may continue after the lesson screen is disposed.

## 5. PlayerManager Requirements
   ### 5.1 Instance Scope

Exactly one PlayerManager instance per lesson screen.

It must not be a global singleton.

It must be disposed when the lesson screen is disposed.

## 5.2 Internal Constraints

The implementation must:

Use a single AudioPlayer instance.

Use positionStream to detect segment end.

Maintain only one active positionStream subscription.

Cancel previous subscriptions before starting new playback.

Cancel any active playback before starting new playback.

Convert seconds to Duration internally.

Timers must not be used.

## 5.3 Playback Sequence Contract

When play(word) is invoked:

Stop any existing playback.

Cancel any existing positionStream subscription.

Convert timestamps to Duration.

Seek to startSeconds.

Start playback.

Attach a new positionStream listener.

Stop playback when position ≥ endSeconds.

Late stream events from previous playback must not affect current playback.

## 5.4 Disposal Contract

On dispose():

Stop playback.

Cancel active subscription.

Dispose AudioPlayer.

Leave no active listeners or leaks.

## 6. User Experience Requirements

Tapping a word must immediately trigger its audio segment.

Rapid consecutive taps must:

Always result in only the last tapped word playing.

Never cause overlapping audio.

Never cause crashes.

No audio may continue after navigation away from lesson.

## 7. Edge Cases

The system must safely handle:

Rapid tapping of multiple words.

Tapping the same word repeatedly.

Swiping pages during playback.

Navigating away while seeking.

Calling play during an active seek.

Receiving late positionStream events from previous playback.

In all cases:

Only one segment may play.

No crashes.

No unexpected continuation.

## 8. Non-Goals (Out of Scope)

This implementation does NOT include:

Automatic pause detection.

Multiple audio files per lesson.

Advanced state machine.

Global audio coordination across lessons.

Scalability optimizations for future formats.

Complex playback UI state handling.

The feature is intentionally minimal and optimized for current lesson format.

## 9. Definition of Done

The feature is complete when:

All functional requirements are implemented.

No overlapping playback is possible.

Playback stops correctly at segment boundaries.

Playback stops when leaving the lesson screen.

No memory leaks or active listeners remain after disposal.

Manual testing confirms correct segmented playback behavior.

## 10. Implementation Validation Requirement

The implementation must satisfy all acceptance criteria exactly.

If any requirement conflicts with the proposed implementation approach, it must be identified during planning before coding begins.

Scope expansion is not permitted without updating this specification.