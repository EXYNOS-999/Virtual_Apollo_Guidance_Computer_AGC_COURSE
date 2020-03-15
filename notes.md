# EXPLORING THE AGS CODE

[Virtual Apollo Guidance Computer AGC COURSE](https://app.pluralsight.com/library/courses/moon-landing-apollo-11/table-of-contents)

JULY 20 1969-->LAUNCH 

**Margret Hamilton** -->Leading the AGC group

[Github Repository for the digitized code](https://github.com/chrislgarry/Apollo-11)


Original Apollo 11 guidance computer (AGC) source code for Command Module (Comanche055) and Lunar Module (Luminary099).

The goal is to be a repo for the original Apollo 11 source code; original source scans for Luminary 099 and Comanche 055.


### Contract and Approvals
*Derived from [CONTRACT_AND_APPROVALS.agc]*

This AGC program shall also be referred to as Colossus 2A.

This program is intended for use in the CM as specified in report `R-577`. This program$

Submitted by          | Role | Date
:-------------------- | :--- | :---
Margaret H. Hamilton  | Colossus Programming Leader<br>Apollo Guidance and Navigation |$

Approved by        | Role | Date
:----------------- | :--- | :---
Daniel J. Lickly   | Director, Mission Program Development<br>Apollo Guidance and Navig$
Fred H. Martin     | Colossus Project Manager<br>Apollo Guidance and Navigation Program$
Norman E. Sears    | Director, Mission Development<br>Apollo Guidance and Navigation Pr$
Richard H. Battin  | Director, Mission Development<br>Apollo Guidance and Navigation Pr$
David G. Hoag      | Director<br>Apollo Guidance and Navigation Program | 28 Mar 69
Ralph R. Ragan     | Deputy Director<br>Instrumentation Laboratory | 28 Mar 69

[CONTRACT_AND_APPROVALS.agc]:https://github.com/chrislgarry/Apollo-11/blob/master/Coman$
[1]:https://rawcdn.githack.com/aleen42/badges/c9246f74/src/nasa.svg
[2]:https://www.nasa.gov/mission_pages/apollo/missions/apollo11.html
[3]:http://www.ibiblio.org/apollo/
[4]:http://web.mit.edu/museum/
[5]:http://www.ibiblio.org/apollo/ScansForConversion/Luminary099/
[6]:http://www.ibiblio.org/apollo/ScansForConversion/Comanche055/
[7]:https://github.com/chrislgarry/Apollo-11/blob/master/CONTRIBUTING.md
[8]:https://github.com/rburkey2005/virtualagc


### COVERING THE TERMINOLOGY 


SATURN-5-->TOP SECTION-->APOLLO SPACECREAFT--->FOR TLI-TRANSLUNAR INJECTION.

APOLLO 11-->THREE INDEPENDENT MODULES-->COMMAND-MODULE(BRAIN)
									-->SERVICE MODULE(POWER)
									-->LUNAR MODIULE(LEM/LM)
									
									
RETURN W/ COMMAND AND SERVICE MODULE-->COMMAND MODUOLE WILL DETACH AND RETURN BACK-->FINAL DESCENT 

# FILES 
									
Comanche055-->Command modeule code AGC
Luminary099-->Lunar Module AGC


## EXPLORING THE COMMAND MODULE

AGC CODE-->ASSEMBLY(COED EXTENTION FOR SYNTAX HIGHLIGHTING)
 
AGC-->NOT A GENERAL-PURPOSE COMPUTER 
 
INSTRUCTION SET IS COMPLETELY DIFFERENT AS COMPARED TO OTHER LOW-LEVEL INSTRUCTION SETS

AGC DOES NOT HAVE A CALL STACK 

## SEPARATING THE MONOLITH AND REVEALING COMMENTS
 
 
AGC CODE ON PAPER SCANNED AND DIGITIZED 

COMMANCHE<-->COLLUSUS 2A

ACG DEVELOPED @ MIT UNDER CONTRACT TO NASA 

P00H--> PROGRAM 00-->PUT AGC IN IDLE STATE 


ENEMA SUBROUTINE --> COMPLETE RESET OF ALL SYSTEMS 

## VERBS NOUNS AND ERROR CODES 

EG-->TEST LIGHT,PERFORM ENGINE FAIL PROCEDUTE
NOUN -->LAT/LONG/ATL 
ALARM CODES-->IMU NOT OPERATING // 1201 1202-->HAPPENED -->BOTH RADARS OM-->OVER LOAD ON THE PROCESSOR--> AGC WAS DESIGNED TO DROP THE LOWER PRIORITY TASKS.

## USING THE DSKY

DISPLAY AND KEYBOARD

SYMSONIAN WEBSITE VR TOUR OF APOLLO MODULE 

CHEKC OUT SIMULATOR FOR AGC APOLLO 9 


## EMULATORS AND SIMULATIONS 




