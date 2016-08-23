### FILE="Main.annotation"
# Copyright:	Public domain.
# Filename:	EXTENDED_VERBS_FOR_MODING.agc
# Purpose:	Part of the source code for Solarium build 55. This
#		is for the Command Module's (CM) Apollo Guidance
#		Computer (AGC), for Apollo 6.
# Assembler:	yaYUL --block1
# Contact:	Jim Lawton <jim DOT lawton AT gmail DOT com>
# Website:	www.ibiblio.org/apollo/index.html
# Page scans:	www.ibiblio.org/apollo/ScansForConversion/Solarium055/
# Mod history:	2009-10-08 JL	Created.
#		2009-08-19 RSB	Typos.
#		2016-08-23 RSB	More of the same.

## Page 235

# VERB PLEASE PERFORM AND VERB PLEASE MARK ----- FLASH SHOULD BE TURNED ON
# (FLASHON) BY ROUTINE PASTING EITHER UP. FLASH IS TURNED OFF BY ENTER OF
# PLEASE PERFORM, OR ENTER OF PLEASE MARK.
#
# BOTH FLASHON AND FLASHOFF MUST NOT BE USED IN INTERRUPTED STATE.
#
# PLEASE PERFORM VERB AND PLEASE MARK VERB-----
# PRESSING ENTER INDICATES ACTION REQUESTED HAS
# BEEN PERFORMED, AND DOES SAME RECALL AS A COMPLETED LOAD. OPERATOR
# SHOULD DO VERB PROCEED WITHOUT DATA IF WISHES NOT TO PERFORM THE
# REQUESTED ACTION.



# FAN-OUT

		SETLOC	12000
		
PINTEST		EQUALS			# THIS MUST BE 05,6000 FOR PINBALL
					# VERIFIFCATION.  DO NOT MOVE WITHOUT
					# INFORMING ALAN GREEN.

LST2FAN		TC	VBZERO		# VB40 ZERO(USED WITH NOUN ICDU OR OCDU)
		TC	VBCOARK		# VB41 COARSE ALIGN(USED WITH NOUN ICDU
					#            OR OCDU)
		TC	IMUFINEK	# VB42 FINE ALIGN IMU
		TC	IMULOCKK	# VB43 LOCK IMU
		TC	IMUATTCK	# VB44 SET IMU TO ATTITUDE CONTROL
		TC	IMUREENK	# VB45 SET IMU TO RE-ENTRY CONTROL
		TC	IMUCORK		# VB46  RETURN IMU TO COARSE ALIGN
		TC	ALM/END		# VB57 OPTICAL TRACKER ON(NOT IN USE YET)
		TC	GOLOADLV	# VB50 PLEASE PERFORM
		TC	GOLOADLV	# VB51 PLEASE MARK
		TC	DOMKREJ		# VB52 MARK REJECT (UNTIL BUTTON AVAIL.)
		TC	RELO/IK		# VB53 FREE  (USED WITH NOUN ICDU OR OCDU)
		TC	TORQGYRS	# VB54 PLUSE TORQUE GYROS
		TC	ALINTIME	# VB55 ALIGN TIME
		TC	GOSHOSUM	# VB56 PERFORMS BANKSUM
		TC	SYSTEST		# VB57 DO SYSTEM TEST
		TC	PRESTAND	# VB60 PREPARE FOR STANDBY
		TC	POSTAND		# VB61 RECOVER FROM STANBBY
		NOOP			# ILLEGAL VERB.
		NOOP			# ILLEGAL VERB.
		NOOP			# ILLEGAL VERB.
		NOOP			# ILLEGAL VERB.
		NOOP			# ILLEGAL VERB.
		NOOP			# ILLEGAL VERB.
		TC	ALM/END
		TC	71JUMPTO	# VERB 71 IS TFFMIN UPDATE
		TC	ABRTJPTO	# VERB 72 ABORTS
## Page 236
		NOOP			# ILLEGAL VERB.
		TC	ALM/END
		TC	EXTRAI/O	# VB75 MANUAL INPUT/OUTPUT OPTIONS.
		TC	76JUMPTO	# VERB 76 IS STATE VECTOR UPDATE
		TC	POSTJUMP	# VERB 77 IS L/O TIME UPDATE
		CADR	77UPDATE
76JUMPTO	TC	POSTJUMP
		CADR	76UPDATE
71JUMPTO	TC	POSTJUMP
		CADR	71UPDATE
ABRTJPTO	TC	POSTJUMP
		CADR	ABORTRPT
		
TESTXACT	CAF	BIT3
		MASK	EXTVBACT
		CCS	A
		TC	XACTALM
		
XACT1		CS	BIT3
		INHINT
		MASK	EXTVBACT
		AD	BIT3
		TS	EXTVBACT
		RELINT
		TC	Q
		
XACTALM		TC	FALTON
		TC	ENDOFJOB
		
TERMEXTV	TC	FREEDSP		# IF WE GET A TERMINATE INSTEAD OF A LOAD.

ENDEXTVB	TC	XACT0
		TC	ENDOFJOB
		
XACT0		CS	BIT3
		INHINT
		MASK	EXTVBACT
		TS	EXTVBACT
		RELINT
		TC	Q
		
		
		
ALM/END		TC	FALTON
		TC	ENDEXTVB
		
		
		
VBZERO		TC	OP/INERT
		TC	IMUZEROK	# RETURN HERE IF NOUN = ICDU(20)
## Page 237
		TC	ALM/END		# RETURN HERE IF NOUN = OCDU(55)
					#         (NOT IN USE YET)
		
VBCOARK		TC	OP/INERT
		TC	IMUCOARK	# RETURN HERE IF NOUN = ICDU(20)
		TC	OPTCOARK	# RETURN HERE IF NOUN = OCDU(55)

## Page 238

#	SUBROUTINE FOR CHECKING GIVEN NOUN IF APPROPRIATE.

OP/INERT	XCH	Q		# RETURNS TO L+1 IF NOUN=ICDU(20)
		TS	WDRET		# RETURNS TO L+2 IF NOUN = OCDU(55)
		CS	NNICDU		#   ALARMS IF ANY OTHER NOUN
		AD	NOUNREG
		CCS	A
		TC	+4		# NN G/ 20
NNICDU		OCT	20
		TC	ALM/END		# NN L/ 20
		TC	WDRET		# NN = 20
		CS	NNOCDU
		AD	NOUNREG
		CCS	A
		TC	ALM/END		# NN G/ 55
NNOCDU		OCT	55
		TC	ALM/END		# NN L/ 55
		INDEX	WDRET		# NN = 55
		TC	1
		
## Page 239

# KEYBOARD REQUEST TO ZERO IMU ENCODERS

IMUZEROK	TC	TESTXACT	# ZERO ENCODERS.
		TC	BANKCALL
		CADR	IMUZERO
		
		TC	BANKCALL	# STALL
		CADR	IMUSTALL
		TC	+1
		
ENDMZERO	INHINT
		CS	ZLITBITS	# TURN OFF ZEROING LIGHT TO SHOW COMPLETE.
		MASK	DSPTAB +11D
		AD	BIT15
		TS	DSPTAB +11D
		TC	ENDEXTVB
		
## Page 240

# KEYBOARD REQUEST TO COARSE ALIGN THE IMU

IMUCOARK	TC	TESTXACT	# COARSE ALIGN FROM KEYBOARD.
		TC	GRABDSP
		TC	PREGBSY
		CAF	VNLODCDU	# CALL FOR THETAD LOAD
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE		# STALL WAITING FOR THE LOAD
		TC	TERMEXTV
		TC	ICSDEL		# PROCEED - ASK FOR INCREMENTAL LOAD.
		
ICORK2		CAF	IMUCOARV	# RE-DISPLAY COARSE ALIGN VERB.
		TC	NVSUB
		TC	PRENVBSY
		TC	FREEDSP		# RELEASE THE DISPLAYS
		
		TC	BANKCALL	# CALL MODE SWITCHING PROG
		CADR	IMUCOARS
		
		TC	BANKCALL	# STALL
		CADR	IMUSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
VNLODCDU	OCT	02522
IMUCOARV	OCT	04100

## Page 241

#	PROVISION FOR COARSE ALIGN TO INCREMENT ANGLES.

ICSDEL		CAF	DELLOAD
		TC	NVSUB		# REQUEST LOAD OF DELTA ICDU ANGLES.
		TC	PRENVBSY
		TC	ENDIDLE
		TC	TERMEXTV
		TC	ICORK2		# PROCEED WITHOUT DATA HERE TOO.
		TC	INCLOOP		# LOOP TO INCREMENT THETAD FROM DSPTEM2.
		TC	ICORK2		# RE-DISPLAY COARSE ALIGN VERB.
		
INCLOOP		XCH	Q		# INCREMENTS THETADS IN 2S COMPLEMENT FROM
		TS	MPAC		#  THREE ANGLE INCREMENTS IN DSPTEM2S.
		CAF	LTHD+2
		TS	BUF		# SET UP FOR CDUINC.
		CAF	TWO		# THREE TIMES THROUGH.
		
INCLOOP2	TS	MPAC +1
		INDEX	A
		XCH	DSPTEM2		# INCREMENT TO TEM2 FOR CDUINC.
		TC	BANKCALL
		CADR	CDUINC
		CCS	BUF
		TS	BUF
		CCS	MPAC +1
		TC	INCLOOP2
		
		TC	MPAC		# RETURN WHEN FINISHED.
		
DELLOAD		OCT	02523
LTHD+2		ADRES	THETAD +2

## page 242

# KEYBOARD REQUEST TO FINE ALIGN AND GYRO TORQUE IMU

IMUFINEK	TC	TESTXACT	# FINE ALIGN WITH GYRO TORQUING.
		TC	GRABDSP
		TC	PREGBSY
		CAF	VNLODGYR	# CALL FOR LOAD OF GYRO COMMANDS
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE		# HOLD UP FOR THE DATA LOAD
		TC	TERMEXTV
		TC	+1		# PROCEED WITHOUT A LOAD
		
		CAF	IMUFINEV	# RE-DISPLAY OUR OWN VERB
		TC	NVSUB
		TC	PRENVBSY
		TC	FREEDSP		# RELEASE DISPLAYS
		
		TC	BANKCALL	# CALL MODE SWITCH PROG
		CADR	IMUFINE
		
		TC	BANKCALL	# HIBERNATION
		CADR	IMUSTALL
		TC	ENDEXTVB
		CAF	LGYROBIN	# PINBALL LEFT COMMANDS IN OGC REGIST5RS
		TC	BANKCALL
		CADR	GYRODPNT
		
		TC	BANKCALL	# WAIT FOR PULSES TO GET OUT.
		CADR	IMUSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
VNLODGYR	OCT	02567
IMUFINEV	OCT	04200		# FINE ALIGN VERB

## Page 243

# KEYBOARD REQUEST TO LOCK THE IMU CDUS

IMULOCKK	TC	TESTXACT
		TC	BANKCALL
		CADR	IMULOCK
		
		TC	BANKCALL	# STALL
		CADR	IMUSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
## page 244

# KEYBOARD REQUEST TO PUT IMU IN ATTITUDE CONTROL MODE

IMUATTCK	TC	TESTXACT	# ATTITUDE CONTROL.
		TC	GRABDSP
		TC	PREGBSY
		CAF	DELLOAD		# ASK FOR DELTA ANGLE LOAD.
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE		# STALL WAITING FOR LOAD
		TC	TERMEXTV
		TC	ATTCABS		# PROCEED - ASK FOR ABSOLUTE ANGLES.
		TC	INCLOOP		# ADD INCREMENTS TO DESIRED ANGLES.
		
ATTCK2		CAF	IMUATTCV
		TC	NVSUB
		TC	PRENVBSY
		TC	FREEDSP		# LET THE DISPLAYS GO
		
		TC	BANKCALL	# CALL THE MODE SWITCH PROG
		CADR	IMUATTC
		
		TC	BANKCALL	# STALL
		CADR	IMUSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
# PROVISIONS FOR ABSOLUTE LOAD FOR IMU CDUS IN ATTITUDE CONTROL.

ATTCABS		CAF	VNLODCDU	# ASK FOR ABSOLUTE CDU ANGLES.
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE
		TC	TERMEXTV
		TC	ATTCK2
		TC	ATTCK2		# SECOND PROCEED WITHOUT DATA.
		
IMUATTCV	OCT	04400

## Page 245

# KEYBOARD REQUEST TO PUT IMU IN RE-ENTRY CONTROL MODE

IMUREENK	TC	TESTXACT	# RE-ENTRY.
		TC	GRABDSP
		TC	PREGBSY
		CAF	DELLOAD		# LOAD INCREMENTAL ANGLES.
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE		# STALL FOR THE LOAD
		TC	TERMEXTV
		TC	REENTABS	# PROCEED - ASK FOR ABSOLUTE LOAD.
		TC	INCLOOP
		
REENTK2		CAF	IMUREENV	# RE-DISPLAY VERB.
		TC	NVSUB
		TC	PRENVBSY
		TC	FREEDSP		# LET THE DISPLAYS GO
		
		TC	BANKCALL	# CALL MODE SWITCH PROG
		CADR	IMUREENT
		
		TC	BANKCALL	# STALL
		CADR	IMUSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
REENTABS	CAF	VNLODCDU	# REQUEST ABSOLUTE ANGLES.
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE
		TC	TERMEXTV	# TERMINATE
		TC	REENTK2
		TC	REENTK2
IMUREENV	OCT	04500

## Page 246

# KEYBOARD REQUEST TO RETURN THE IMU TO COARSE ALIGN

IMUCORK		TC	TESTXACT	# BACK TO COARSE ALIGN (FROM FINE).
		TC	BANKCALL
		CADR	IMURECOR
		
		TC	BANKCALL
		CADR	IMUSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
## Page 247

# KEYBOARD REQUEST TO ZERO OPTICS CDUS

OPTZEROK	TC	BANKCALL	# CALL MODE PROG
		CADR	OPTZERO
		
		TC	BANKCALL	# STALL
		CADR	OPTSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
OPTZERO		=			# INTERFACES NOT CURRENTLY WIRED *********

## Page 248

# TEMPORARY ROUTINE TO RUN THE OPTICS CDUS FROM THE KEYBOARD

OPTCOARK	TC	GRABDSP		# SNATCH THEM DISPLAYS
		TC	PREGBSY
		CAF	VNLDOCDU	# VERB-NOUN TO LOAD OPTICS CDUS
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE		# WAIT FOR THE LOAD
		TC	TERMEXTV
		TC	+1		# PROCEED
		
		CAF	OPTCOARV	# RE-DISPLAY OUR OWN VERB
		TC	NVSUB
		TC	PRENVBSY
		TC	FREEDSP		# LET IT GO
		
		CAF	ZERO
		TS	OPTIND		# SNATCH OPTICS
		
		TC	ENDEXTVB
		
VNLDOCDU	OCT	02457
OPTCOARV	EQUALS	IMUCOARV	# DIFFERENT NOUNS.

## Page 249 

# KEYBOARD REQUEST TO ACTIVATE THE OPTICAL STAR TRACKER

OPTTRONK	TC	BANKCALL
		CADR	OPTTRKON	# CALL MODE SWITCHER
		
		TC	BANKCALL	# STALL
		CADR	OPTSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
OPTTRKON	=			# NOT AVAILABLE JUST NOW

DOMKREJ		INHINT			# DO 10 MS WAITLIST CALL TO MK REJECT PROG
		CS	MARKSTAT	# MARK REJECT IS ENABLED ONLY IF BIT10
		MASK	BIT10		# OF MARKSTAT = 1.
		CCS	A
		TC	ALM/END
		
		CAF	ONE
		TC	WAITLIST
		CADR	MKREJECT	# (CALLED IN KEYRUPT WHEN BUTTON AVAIL.)
		CAF	HI5		# MARK REJECT ROUTINE WILL RE-PASTE VB51
		MASK	MARKSTAT	# IF ALL MARKS WERE IN.
		CCS	A
		TC	+2
		TC	ENDOFJOB
		
		RELINT
		TC	BANKCALL	# RE-DISPLAY VB 51 SINCE MORE MARKS
		CADR	FLASHON		# REQUIRED.
		TC	POSTJUMP
		CADR	REMKVB51
		
# PLEASE PERFORM VERB AND PLEASE MARK VERB ----- PRESSING ENTER INDICATES
# ACTION REQUESTED HAS BEEN PERFORMED, AND DOES SAME RECALL AS A COMPLETED
# LOAD.  OPERATOR SHOULD DO VB PROCEED WITHOUT DATA IF HE WISHES NOT TO
# PERFORM THE REQUESTED ACTION.

GOLOADLV	TC	BANKCALL
		CADR	FLASHOFF
		TC	XACT0
		TC	POSTJUMP
		CADR	LOADLV1
		
## Page 250

# KEYBOARD REQUEST TO RELEASE IMU OR OPTICS

RELO/IK		TC	OP/INERT
		TC	IMURELK		# RETURN HERE IF IMU
		CS	ZERO		# RETURN HERE IF OPTICS
		TS	OPTIND
		TC	ENDOFJOB
		
IMURELK		CS	ZERO
		TS	CDUIND
		TC	ENDOFJOB
		
## Page 251

# KEYBOARD REQUEST TO PLUSE TORQUE IRIGA



TORQGYRS	TC	TESTXACT	# GYRO TORQUING WITH NO MODE-SWITCHING.
		TC	GRABDSP
		TC	PREGBSY
		CAF	VNLODGYR
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE
		TC	TERMEXTV
		TC	+1
		CAF	TORQGYRV	# RE-DISPLAY OUR OWN VERB
		TC	NVSUB
		TC	PRENVBSY
		TC	FREEDSP
		CAF	LGYROBIN
		TC	BANKCALL
		CADR	GYRODPNT
		TC	BANKCALL	# WAIT FOR PULSES TO GET OUT.
		CADR	IMUSTALL
		TC	ENDEXTVB
		TC	ENDEXTVB
		
LGYROBIN	ADRES	OGC
TORQGYRV	OCT	05400

## Page 252

# ALIGN TIME
ALINTIME	CAF	VNLODDT		# USES NVSUBMON. DOES NOT TEST DSPLOCK.
		TS	NVTEMP		# DOES NOT KILL MONITOR.
		TC	NVSUBMON
		TC	ENDOFJOB	# IN CASE OF ALARM IN LOAD REQUEST SET UP.
		TC	ENDIDLE
		TC	ENDOFJOB	# TERMINATE
		TC	ENDOFJOB	# PROCEED WITHOUT DATA
UPDATIME	INHINT			# DELTA TIME IS IN DSPTEM1, +1.
		CAF	ZERO
		TS	MPAC +2		# NEEDED FOR TP AGREE
		XCH	TIME1		# LO ORDER TIME
		AD	DSPTEM1 +1
		TS	MPAC +1
		CAF	ZERO
		AD	DSPTEM1
		AD	TIME2		# HI ORDER TIME
		XCH	MPAC
		TC	BANKCALL
		CADR	TPAGREE
		XCH	MPAC
		XCH	TIME2
		XCH	MPAC +1
		XCH	TIME1
		CCS	A
		TC	+2
		TC	ENDALINE
		CAF	ONE		# TIME1 WAS INCREMENTED SINCE PICKUP
		AD	TIME1
		TS	TIME1
		TC	ENDALINE
		AD	TIME2
		XCH	TIME2
ENDALINE	RELINT
		TC	ENDOFJOB
		
VNLODDT		OCT	02124		# V/N FOR LOAD DELTA TIME

## Page 253

# PREPARE FOR STANDBY OPERATION
#
# PRESTAND PREPARES FOR STANDBY BY SNAPSHOTTING IN1, TIME1, TIME2 AS SOON 
# AS IN1 CHANGES. IT DOES THIS BY CONTINUOUS WAITLIST REQUESTS UNTIL A
# CHANGE IN IN1 IS DETECTED.
#
# POSTAND RECOVERS TIME AFTER STANDBY. IT WAITS FOR A CHANGE IN IN1 (JUST
# AS PRESTAND DOES), THEN COMPUTES THE DIFFERENCE BETWEEN IN1 VALUES(FULL
# 16 BITS), ADDS THIS TO THE PREVIOUSLY SNAPSHOTTED VALUES OF TIME1, TIME2
# AND PLACES THIS NEW TIME INTO TIME1, TIME2 COUNTERS.



# BIT1 OF IN1LOSAV = LAST VALUE OF BIT1 IN IN1
PRESTAND	INHINT			# PREPARE TIME FOR STANDBY
		CAF	ONE
		TC	WAITLIST
		CADR	PRESTBY
		TC	ENDOFJOB
		
PRESTBY		XCH	IN1		# CALLED BY WAITLIST
		MASK	BIT1		# PUT BIT1 OF IN1 INTO BIT1 OF IN1LOSAV
		TS	LPRUPT
		CS	BIT1
		MASK	IN1LOSAV
		AD	LPRUPT
		TS	IN1LOSAV
					# CALLED BY WAITLIST EVERY 10 MSEC
PRESTBY1	XCH	IN1		# UNTIL A CHANGE IN IN1 IS DETECTED.
		XCH	Q		# PUT ALL 16 BITS OF IN1 INTO Q
		CS	TIME1		# SNAPSHOT TIME1
		XCH	TIME1SAV
		CS	TIME2		# SNAPSHOT TIME2
		XCH	TIME2SAV
		XCH	Q		# PUT ALL 16 BITS OF IN1 INTO A
		TC	IN1LOOK
		TC	PRESTBY2	# RETURNS HERE IF NO CHANGE IN IN1
		XCH	IN1HITEM	# RETURNS HERE IF IN1 HAS CHANGED
		TS	IN1HISAV
		XCH	IN1LOTEM	# DONE WITH BIT1 OF IN1LOSAV, DONT PROTECT
		TS	IN1LOSAV
		TC	TASKOVER
		
PRESTBY2	CAF	ONE		# PERPETUATES WAITLIST REQUEST EVERY 
		TC	WAITLIST	# 10 MSEC UNTIL INI CHANGES.
		CADR	PRESTBY1
		TC	TASKOVER
		
## Page 254

# IN1LOOK RETURNS TO L+1 IF IN1 HAS NOT CHANGED SINCE LAST EXAMINATION.
# IT RETURNS TO L+2 IF IN1 HAS CHANGED SINCE LAST EXAMINATION, WITH
# BITS 16-8 OF IN1 IN BITS 9-1 OF IN1HITEM, AND BITS 7-1 OF IN1
# IN BITS 14-8 OF IN1LOTEM.

IN1LOOK		TS	IN1LOTEM
		CAF	NEG0
		TS	IN1HITEM	# PUT +1 FOR OF, -1 FOR UF, -0 FOR NEITHER
		XCH	Q
		TS	LOOKRET
		CAF	BIT1
		MASK	IN1LOTEM
		TS	LPRUPT		# NEW VALUE OF BIT1 OF IN1
		CAF	BIT1
		MASK	IN1LOSAV	# LAST VALUE OF BIT1 OF IN1
		EXTEND
		SU	LPRUPT
		CCS	A
		TC	IN1PREP		# IN1 HAS CHANGED
		TC	CCSHOLE
		TC	IN1PREP		# IN1 HAS CHANGED
		TC	LOOKRET		# IN1 HAS NOT CHANGED. RETURN TO L+1.
IN1PREP		XCH	LP
		TS	LPRUPT		# STORE LP
		XCH	IN1LOTEM
		EXTEND
		MP	BIT8		# SHIFTS RIGHT 7
		XCH	IN1HITEM	# PUTS BITS7-1 OF IN1 INTO BITS 14-8 OF LP
		CCS	A		# PUTS BITS14-8 OF IN1 INTO BITS7-1 OF A
		CAF	BIT8		# PUTS BIT16 OF IN1 INTO BIT9 OF A
		TC	+2
		CS	BIT8
		AD	IN1HITEM	# PUTS BIT15 OF IN1 INTO BIT8 OF A
		MASK	LOW9
		TS	IN1HITEM
		XCH	LP
		MASK	B14-B8		# BIT14 THRU BIT8
		TS	IN1LOTEM
		CAF	BIT1
		EXTEND
		MP	LPRUPT		# RESTORE LP
		INDEX	LOOKRET
		TC	1		# RETURN TO L+2
B14-B8		OCT	37600

## Page 255

# RECOVER FROM STANDBY OPERATION

POSTAND		INHINT			# RECOVER TIME AFTER STANDBY
		CAF	ONE
		TC	WAITLIST
		CADR	POSTBY
		TC	ENDOFJOB
		
POSTBY		XCH	IN1		# CALLED BY WAITLIST
		MASK	BIT1		# PUT BIT1 OF IN1 INTO BIT1 OF IN1LOSAV
		TS	LPRUPT
		CS	BIT1
		MASK	IN1LOSAV
		AD	LPRUPT
		TS	IN1LOSAV
					# CALLED BY WAITLIST EVERY 10 MSEC UNTIL
POSTBY1		XCH	IN1		# A CHANGE IN IN1 IS DETECTED.
		XCH	Q		# PUT ALL 16 BITS OF IN1 INTO Q
		CAF	ZERO
		TS	TIME1		# ZERO TIME1, TIME2 IN ANTICIPATION
		TS	TIME2		# OF UPDATING.
		XCH	Q		# PUT ALL 16 BITS OF IN1 INTO A
		TC	IN1LOOK
		TC	POSTBY2		# RETURNS HERE IF IN1 HAS NOT CHANGED
		CS	BIT1		# RETURNS HERE IF IN1 HAS CHANGED
		MASK	IN1LOSAV	# FORM DP DIFFERENCE OF C(IN1) TAKEN AFTER
		COM			# STANDBY MINUS C(IN1) TAKEN BEFORE
		AD	IN1LOTEM	# STANDBY. THIS DIFF IS IN THE BITS
		TS	IN1LODIF	# CORRESPONDING TO TIME1, TIME2.
		CAF	ZERO
		AD	IN1HITEM
		EXTEND
		SU	IN1HISAV
		CCS	A
		AD	ONE		# DIFF IS +
		TC	+2
		TC	DIFFNEG		# DIFF IS -NZ, ADD BIT10 TO HI PART
DIFFCOM		TS	IN1HIDIF
		CAF	PRIO33		# GO TO EXEC TO FINISH UP
		TC	NOVAC		# GO TO EXEC TO FINISH UP
		CADR	POSTBY3
		TC	TASKOVER
		
DIFFNEG		AD	ONE
		COM
		AD	BIT10
		TC	DIFFCOM
		
POSTBY2		CAF	ONE		# PERPETUATES WAITLIST REQUEST EVERY
		TC	WAITLIST	# 10 MSEC UNTIL INI CHNAGES.
## Page 256
		CADR	POSTBY1
		TC	TASKOVER
		
		

POSTBY3		CS	TIME1SAV	# CALLED BY EXEC
		AD	IN1LODIF	# TIME WAS STORED COMP
		TS	MPAC +1
		CAF	ZERO
		AD	IN1HIDIF
		EXTEND
		SU	TIME2SAV	# TIME WAS STORED COMP
		TS	MPAC
		TC	+1		# JUST IN CASE OF OF
		CAF	ZERO		# MAKES TPAGREE SAFE FOR DPAGREE
		TS	MPAC +2
		TC	BANKCALL
		CADR	TPAGREE
		XCH	MPAC +1
		TS	DSPTEM1 +1
		XCH	MPAC
		TS	DSPTEM1
		TC	UPDATIME
		
## Page 256

#	SELECT AND INITIATE DESIRED SYSTEM TEST PROGRAM.

SYSTEST		TC	GRABDSP		# FIXED BY THE PHANTI
		TC	PREGBSY
		CCS	MODREG		# MUST NOT BE RUNNING ANYTHING.
		TC	XVBOUT
		
		TC	NEWMODE		# FOR SYSTEM TEST.
		OCT	07
		
REDO		CAF	LQPL		# ASK FOR TEST OPTION (1 - 7).
		TS	MPAC +2
		CAF	TESTNV
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE
		TC	XVBOUT
		TC	REDO
		
		INHINT
		CAF	PRIO20
		TC	FINDVAC
		CADR	TSELECT
		TC	ENDOFJOB	# LEAVING DISPLAY GRABBED FOR SYSTEM TEST.
		
TSELECT		CAF	SEVEN
		MASK	QPLACE		# SAFETY PLAY.
		INDEX	A
		CAF	TESTCADR
		TC	BANKJUMP
		
TESTCADR	CADR	ALM/END		# 0  ILLEGAL.
		CADR	GYDRFT		# 1 GYRO DRIFT TEST.
		CADR	ACCELTST	# 2  PIPA SCALE FACTOR DETERMINATION.
		CADR	ALGNTST		# 3  IMU ALIGNMENT TEST.
		CADR	IMUCHK		# 4  IMU CHECK.
		CADR	GYROTORK	# 5  GYRO TORQUING TEST.
		CADR	CCHK		# 6  C RELAY CHECK.
		CADR	DCHECK		# 7  DSKY CHECK.
		
TESTNV		OCT	02101
LQPL		ADRES	QPLACE
GOSHOSUM	TC	POSTJUMP	# START ROUTINE TO DISPLAY SUM OF EACH
		CADR	SHOWSUM		# BANK ON DSKY
		
## Page 258

#	VERB 75 ALLOWS THE GROUND TO PERFORM SOME I/O OPERATIONS WITH THE DSKY. FOUR OPTIONS ARE
# MECHANIZED FOR FLIGHT 501 (WITH MAJOR MODES DURING WHICH ALLOWED) -
#	1	GIMBAL MOTOR POWER ON			MAJOR MODES 0X.
#	2	GIMBAL MOTOR POWER OFF			MAJOR MODES 0X.
#	3	LIFT-OFF (AND GUIDANCE RELEASE).	MAJOR MODES 01 AND 04.
#	4	S4B-SM SEPARATE				MAJOR MODE 14.
#	5	FDAI ALIGN.				MAJOR MODES 0X.

EXTRAI/O	TC	GRABDSP
		TC	PREGBSY
75RELOAD	CAF	LV75TEMP	# ASK FOR FUNCTION NUMBER.
		TS	MPAC +2
		CAF	STATENV
		TC	NVSUB
		TC	PRENVBSY
		TC	ENDIDLE
		TC	XVBOUT
		TC	75RELOAD
		
		CCS	V75TEMP		# MAKE SURE FUNCTION NUMBER IS LEGIT.
		TC	+4
		TC	75RELOAD
		TC	75RELOAD
		TC	75RELOAD
		
 +4		MASK	75HI12
		CCS	A
		TC	75RELOAD
		
		INDEX	V75TEMP
		TC	+0
		TC	75FN1
		TC	75FN2
		TC	75FN3
		
		TC	75FN4
		TC	75FN5
		TC	75RELOAD
		TC	75RELOAD
		TC	75RELOAD

## Page 259

#	FUNCTION 4 - DO S4B SEPARATE.

75FN4		TC	CHECKMM		# NO MODE 13 IS PLANNED.
		OCT	14
		TC	MALAPROP
		
		INHINT
		CAF	BIT8
		MASK	FLAGWRD1
		CCS	A
		TC	XVBOUT		# SWITCH SET - FUNCTION ALREADY DONE.
		
		CAF	PRIO25
		TC	FINDVAC
		CADR	S4BSMSEP
		
		TC	XVBOUT
		
#	FUNCTION 1 - GIMBAL MOTOR POWER ON - DURING PRE-LAUNCH ONLY.

75FN1		CAF	75MASK
		MASK	MODREG
		CCS	A
		TC	MALAPROP
		
		TC	RELAYON
		OCT	40200
		
		TC	XVBOUT
		
#	FUNCTION 2 - GIMBAL MOTOR POWER OFF - DURING PRE-LAUNCH ONLY.

75FN2		CAF	75MASK
		MASK	MODREG
		CCS	A
		TC	MALAPROP
		
		TC	RELAYOFF
		OCT	40200
		
		TC	XVBOUT
		
## Page 260

#	FUNCTION 3 - DO LIFT-OFF IN MAJOR MODE 04

75FN3		TC	CHECKMM		# TEST IF PLATFORM IS INERTIAL (MM 04)
		OCT	4
		TC	CHECKM02	# IT IS NOT. TEST IF STILL GYROCOMPASSING
		
 +3		INHINT
		CAF	BIT2
		MASK	FLAGWRD1
		CCS	A
		TC	XVBOUT
		
		CAF	PRIO24
		TC	FINDVAC
		CADR	LIFTOFF
		
		TC	XVBOUT
		
CHECKM02	TC	CHECKMM		# CHECK IF GYROCOMPASSING
		OCT	00002
		TC	MALAPROP	# NOT INERTIAL OR GYROCOMPASSING
		TC	75FN3 +3
		
#	FUNCTION 5 - FDAI ALIGN ON.

75FN5		CAF	75MASK
		MASK	MODREG
		CCS	A
		TC	MALAPROP
		TC	RELAYON
		OCT	40400
		INHINT
		CAF	10SECS75	# TURN OFF IN 10 SECONDS.
		TC	WAITLIST
		CADR	FDOFTSK1
		TC	XVBOUT
-.5SEC75	DEC	-50
75MASK		OCT	70
75HI12		OCT	77770
10SECS75	DEC	1000
LV75TEMP	ADRES	V75TEMP

## Page 261

# THE FOLLOWING PROGRAM IMPLEMENTS MAJOR MODE 27 OF FLIGHT 501 - STATE VECTOR UPDATE.
		BANK	13
76UPDATE	TC	FLAG1DWN	# TURN OFF UPDAOFLG TO ALLOW ANOTHER V76
		OCT	20000
		CS	MINUS14D	# PICK UP NO OF COMPONENTS FOR V76
		TC	DATUPDAT
71UPDATE	CAF	BIT2		# PICK UP NO OF COMPONENTS FOR V71
		TC	DATUPDAT
77UPDATE	CAF	BIT1		# PICK UP NO OF COMPONENTS FOR V71
DATUPDAT	TS	MPAC		# COMES HERE WITH NO OF COMPONENTS IN A
		TC	CHECKMM		# IS THIS P24
		OCT	24
		TC	CK4MM14		# NO,SEE IF IT IS P14
STUFMODE	CS	MODREG
		TS	UPOLDMD		# PUT OLD MODE IN REGISTER FOR DOWNLINK
		CAF	76UPDATE +1
		MASK	FLAGWRD1
		CCS	A		# IS UPDATFLG SET
		TC	XACTALM7	# YES, TURN ON CHECK FAIL AND EXIT
		CAF	LDNLST2		# NO, SET UP UPDATE DOWNLIST
		TS	DNLSTADR
		XCH	MPAC
		TS	COMPNUMB
		TC	NEWMODE
		OCT	27
		CS	LSTBUFF
		TS	-UPADR		# INITIALIZE LOOP
		TC	GRABDSP
		TC	PREGBSY
		CAF	BIT1
NEXTCOMP	TS	STCNTR
OHWELL		CS	-UPADR
		TS	MPAC +2
		CAF	STATENV7
		TC	NVSUB		# SET UP FOR COMPONENT LOAD
		TC	PRENVBSY
		TC	ENDIDLE		# WAIT FOR INPUT
		TC	ENDUPDAT	# V34 E, TERMINATE
		TC	OHWELL		# V33E, MAKES NO SENSE, RECYCLE
		CS	ONE		# COMPONENT LOADED
		AD	-UPADR
		TS	-UPADR		# CHANGE LOAD ADDRESS
		TC	CHECKMM		# ARE WE STILL IN P27
		OCT	27
		TC	ENDUPDAT	# NO, TIME HAS RUN OUT, EXIT
		CS	STCNTR		# YES, CONTINUE
		AD	COMPNUMB
		CCS	A		# WAS THAT THE LAST COMPONENT
		CS	A		# NO, CALCULATE NEW STCNTR
		AD	COMPNUMB
## Page 262
		TC	NEXTCOMP	# RECYCLE
NEXTCHGE	CAF	L-UPADR		# YES, SET UP FOR OCTAL ID IF NEEDED
		TS	MPAC +2
		CAF	OCT1DNV
		TC	NVSUB		# DISPLAY VERIFICATION V21N02
		TC	PRENVBSY
		TC	ENDIDLE		# WAIT FOR INPUT
		TC	ENDUPDAT	# V34E, TERMINATE
		TC	UPDTDONE	# V33E, UPDATE VERIFIED
		CCS	-UPADR		# IS OCTAL ID PNZ
		TC	+4		# YES, TEST FURTHER
		TC	NEXTCHGE	# NO, BAD ID, RECYCLE
		TC	NEXTCHGE	# NO, BAD ID, RECYCLE
		TC	NEXTCHGE	# NO, BAD ID, RECYCLE
		CS	COMPNUMB
		AD	-UPADR
		CCS	A		# IS ID TOO BIG
		TC	NEXTCHGE	# YES, BAD ID, RECYCLE
OCT1DNV		OCT	02102		# CANNOT COME HERE
		NOOP			# NO, GOOD ID
		CCS	-UPADR		# NO, GOOD ID
		AD	LSTBUFF
		TC	OHWELL +1
CK4MM14		TC	CHECKMM		# COMES HERE TO SEE IF IN P14
		OCT	14
		TC	XACTALM7	# NO, TURN ON CHECK FAIL
		TC	STUFMODE	# YES, SAVE MODE AND START P27
UPDTDONE	CCS	COMPNUMB	# COMES HERE AFTER VERIFIED UPDATE
		CCS	A		# TEST NO OF COMPONENTS TO TELL WHICH UPDT
		TC	TESTMORE
77CONTIN	INHINT			# 1 COMPONENT, V77 UPDATE
		XCH	DTEPOCH +1
		AD	STBUFF		# ADD TO DTEPOCH
		TS	MPAC +2
		CAF	ZERO
		AD	DTEPOCH
		TS	MPAC +1
		CAF	ZERO
		TS	MPAC
		TC	BANKCALL	# FORCE SIGN AGREEMENT
		CADR	TPAGREE
		CAF	ZERO
		TS	DSPTEM1		# INITIALIZE REGISTERS FOR CLOCK INCREMENT
		CS	STBUFF
		TS	DSPTEM1 +1
		XCH	MPAC +1
		TS	DTEPOCH		# REPLACE WITH NEW DTEPOCH
		XCH	MPAC +2
		TS	DTEPOCH +1
ALLDONE		INHINT			# STANDARD EXIT FOR SUCCESSFUL UPDATES
## Page 263
		CS	STATE		# INVERT VERIFLAG ON COMPLETED UPDATES
		MASK	BIT6
		TS	Q
		CS	BIT6
		MASK	STATE
		AD	Q
		TS	STATE
		RELINT
		TC	CHECKMM
		OCT	27
		TC	+4		# NO, DO NOT CHANGE PRESENT PROGRAM
		CS	UPOLDMD		# YES, RESTORE P14 OR P24
		TC	NEWMODE +2
LSTBUFF		ADRES	STBUFF
		CAF	LDNLST1		# RESTORE FLIGHT DOWNLINK LIST
		TS	DNLSTADR
		TC	FREEDSP
		CCS	COMPNUMB	# WAS THIS A V77 UPDATE
		CCS	A
		TC	ENDOFJOB	# NO, FINISHED
		TC	POSTJUMP	# YES, GO INCREMENT CLOCK
		CADR	UPDATIME
TESTMORE	CCS	A		# IF NOT V77, WHICH UPDATE WAS IT
		TC	76CONTIN	# V76, CONTINUE AT 76CONTIN
71CONTIN	XCH	STBUFF		# V71, LOAD TFFMIN
		TS	TFFMIN
		XCH	STBUFF +1
		TS	TFFMIN +1
		TC	ALLDONE		# GO TO STANDARD EXIT
76CONTIN	TC	FLAG1UP		# SET UPDATFLG
		OCT	20000
		CAF	BIT4
		MASK	UPOLDMD
		CCS	A		# WAS OLD PROGRAM P14 OR P24
		TC	ALLDONE		# P24, GO TO STANDARD EXIT
		CS	STBUFF +12D	# P14, LOAD UPTIME
		CS	A
		TS	UPTIME
		CS	STBUFF +13D
		CS	A
		TS	UPTIME +1
		TC	ALLDONE		# GO TO STANDARD EXIT
ENDUPDAT	TC	CHECKMM		# COMES HERE ON V34E
		OCT	27		# IS IT STILL P27
		TC	+4		# NO, DO NOT CHANGE PRESENT PROGRAM
		CS	UPOLDMD		# YES, RESTORE P14 OR P24
		TC	NEWMODE +2
MINUS14D	OCT	77761
		CAF	LDNLST1		# RESTORE DOWNLIST
		TS	DNLSTADR
## Page 264
		TC	FREEDSP
		TC	ENDOFJOB	# THATS IT, THERE AINT NO MORE
STATENV7	OCT	02101
L-UPADR		ADRES	-UPADR
XACTALM7	TC	POSTJUMP
		CADR	XACTALM
		BANK	5
STATENV		OCT	02101
MALAPROP	TC	FALTON
XVBOUT		TC	FREEDSP
		TC	ENDOFJOB
REDO5.20	TC	NEWMODE
		OCT	24
		TC	ENDOFJOB
ENDEXTVS	=
