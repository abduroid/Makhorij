# Why
This app plays pronunciation of words. But students should also practice, not just listening.
And word_pager_screen shows one word at a time and plays it. 
Students should practice after teacher's pronunciation. 
And to do better they need to hear how did they sound, was it similar to the teacher's pronunciation.
This way they can notice their mistakes, or just differences. So this leads to improvement.

# What
Recording user's own voice for each word.

# How
## Write a record_manager 
1. It should take which lesson is the recording for
2. Start recording when commanded
3. Stop recording when commanded
4. Save the recording with assigning it to a specific word of a lesson. So it can find when requested
5. A permanent storing is preferred.
6. It should have a method to return the recording for given word of a lesson, 
if it's null then it means we have to record. We use the recording function directly, 
no need to trigger recording automatically
