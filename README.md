ppt-scripts
===========

Usage Instructions
------------------
The link to the page where you can download all the PPT student's submissions looks like the following:

	https://www.doc.ic.ac.uk/~tora/firstyear/ppt/group/[group number]/exercise/[exercise number]

with  
- [group number] being the group number for your PPT group. 
- [exercise number] being the exercise number for the exercise.

The script can be executed in the following way:

1. **./getScripts**  
   This will print a short note of how to use the script and the parameters required.

2. **./getScripts username group-number exercise-number storage-folder**  
   This will download all the submissions for the exercise specified by exercise-number
   and put them in the folder specified by storage-folder (Note: this folder will be
   relative to where to you ran the script from).

3. **./getScripts -p username group-number exercise-number storage-folder**  
   Same as (2.), but will also print the submissions for you (Printer is ICTMono).
