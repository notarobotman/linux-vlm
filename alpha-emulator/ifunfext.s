/************************************************************************
 * WARNING: DO NOT EDIT THIS FILE.  THIS FILE WAS AUTOMATICALLY GENERATED
 * FROM ../alpha-emulator/ifunfext.as. ANY CHANGES MADE TO THIS FILE WILL BE LOST
 ************************************************************************/

/* Field extraction instruction. */
.align 5
.globl DoCharLdb
.ent DoCharLdb 0
/* Field Extraction instruction - DoCharLdb */
	.globl DoCharLdbFP
	.globl DoCharLdbSP
	.globl DoCharLdbLP
	.globl DoCharLdbIM
.align 3
DoCharLdb:
/* Actually only one entry point, but simulate others for dispatch */
#ifdef TRACING
	.byte 0xA0
	.asciiz "DoCharLdb"
#endif
.align 3
DoCharLdbIM:
.align 3
DoCharLdbSP:
.align 3
DoCharLdbLP:
.align 3
DoCharLdbFP:
        srl	$18, 37, $16 	# Shift the 'size-1' bits into place [1]
        and	$17, 31, $17 	# mask out the unwanted bits in arg2 [1]
        and	$16, 31, $16 	# mask out the unwanted bits in arg1 [1]
/* arg1 has size-1, arg2 has position. */
        subq	$31, 1, $7 	# t7= -1 [1]
        ldl	$18, 4($12)	# get ARG1 tag/data [1-]
        ldl	$19, 0($12)	#  [1]
        lda	$16, 1($16)	# Size of field [1-]
        sll	$7, $16, $7 	# Unmask [1]
/* TagType. */
        and	$18, 63, $8 	# [1]
        subq	$8, TypeCharacter, $22 	# [1]
        extll	$19, 0, $19 	# Clear sign extension now [1]
        bne	$22, CHARLDBEXC	# Not a character [0di]
        sll	$19, $17, $4 	# T4= shifted value if PP==0 [2-]
        ldq	$9, CACHELINE_NEXTPCDATA($13)	#  [0di]
        srl	$4, 32, $5 	# T5= shifted value if PP<>0 [2-]
        ldq	$13, CACHELINE_NEXTCP($13)	#  [0di]
        cmoveq	$17, $4, $5 	# T5= shifted value [1-]
        bic	$5, $7, $3 	# T3= masked value. [2]
        bis	$31, TypeFixnum, $4 	# [1]
        stl	$3, 0($12)	#  [0di]
        stl	$4, 4($12)	# write the stack cache [1]
        br	$31, CACHEVALID	# [1]
.align 3
CHARLDBEXC:
        bis	$31, 0, $20 	# [1-]
        bis	$31, 28, $17 	# [1]
	br	$31, ILLEGALOPERAND
.end DoCharLdb
/* End of Halfword operand from stack instruction - DoCharLdb */
.align 5
.globl DoPLdb
.ent DoPLdb 0
/* Field Extraction instruction - DoPLdb */
	.globl DoPLdbFP
	.globl DoPLdbSP
	.globl DoPLdbLP
	.globl DoPLdbIM
.align 3
DoPLdb:
/* Actually only one entry point, but simulate others for dispatch */
#ifdef TRACING
	.byte 0xA0
	.asciiz "DoPLdb"
#endif
.align 3
DoPLdbIM:
.align 3
DoPLdbSP:
.align 3
DoPLdbLP:
.align 3
DoPLdbFP:
        srl	$18, 37, $16 	# Shift the 'size-1' bits into place [1]
        and	$17, 31, $17 	# mask out the unwanted bits in arg2 [1]
        and	$16, 31, $16 	# mask out the unwanted bits in arg1 [1]
/* arg1 has size-1, arg2 has position. */
        ldl	$2, 0($12)	# get arg1 tag/data [0di]
        ldl	$1, 4($12)	#  [1]
        extll	$2, 0, $2 	# [2di]
        subq	$1, TypePhysicalAddress, $3 	# [1]
        and	$3, 63, $3 	# [1]
        beq	$3, PLDBILLOP	# [1]
/* Memory Read Internal */
G15328:
        ldq	$3, PROCESSORSTATE_STACKCACHEBASEVMA($14)	# Base of stack cache [1]
        addq	$2, $14, $5 	# [1-]
        ldl	$4, PROCESSORSTATE_SCOVLIMIT($14)	#  [0di]
        s4addq	$5, $31, $19 	# [1-]
        ldq_u	$18, 0($5)	#  [1di]
        subq	$2, $3, $3 	# Stack cache offset [1-]
        cmpult	$3, $4, $4 	# In range? [1]
        ldl	$19, 0($19)	#  [1-]
        extbl	$18, $5, $18 	# [0di]
        bne	$4, G15330	# [1-]
G15329:
        extll	$19, 0, $19 	# [2di]
G15336:
        subq	$31, 1, $7 	# t7= -1 [1]
        addq	$16, 1, $16 	# Size of field [1]
        sll	$19, $17, $4 	# T4= shifted value if PP==0 [1]
        srl	$4, 32, $5 	# T5= shifted value if PP<>0 [2]
        sll	$7, $16, $7 	# Unmask [1]
        cmoveq	$17, $4, $5 	# T5= shifted value [1]
        bic	$5, $7, $3 	# T3= masked value. [2]
        ldq	$9, CACHELINE_NEXTPCDATA($13)	#  [0di]
        ldq	$13, CACHELINE_NEXTCP($13)	#  [1]
        bis	$31, TypeFixnum, $4 	# [0di]
        stl	$3, 0($12)	#  [1-]
        stl	$4, 4($12)	# write the stack cache [1]
        br	$31, CACHEVALID	# [1]
.align 3
PLDBILLOP:
/* Convert stack cache address to VMA */
        ldq	$2, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1]
        ldq	$1, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1]
        subq	$12, $2, $2 	# stack cache base relative offset [2-]
        srl	$2, 3, $2 	# convert byte address to word address [1]
        addq	$2, $1, $1 	# reconstruct VMA [2]
        bis	$31, $2, $20 	# [1]
        bis	$31, 57, $17 	# [1]
	br	$31, ILLEGALOPERAND	# Physical not supported
.align 3
G15330:
        ldq	$4, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1-]
        s8addq	$3, $4, $3 	# reconstruct SCA [3]
        ldl	$19, 0($3)	#  [2]
        ldl	$18, 4($3)	# Read from stack cache [1]
        br	$31, G15329	# [1]
.end DoPLdb
/* End of Halfword operand from stack instruction - DoPLdb */
.align 5
.globl DoPTagLdb
.ent DoPTagLdb 0
/* Field Extraction instruction - DoPTagLdb */
	.globl DoPTagLdbFP
	.globl DoPTagLdbSP
	.globl DoPTagLdbLP
	.globl DoPTagLdbIM
.align 3
DoPTagLdb:
/* Actually only one entry point, but simulate others for dispatch */
#ifdef TRACING
	.byte 0xA0
	.asciiz "DoPTagLdb"
#endif
.align 3
DoPTagLdbIM:
.align 3
DoPTagLdbSP:
.align 3
DoPTagLdbLP:
.align 3
DoPTagLdbFP:
        srl	$18, 37, $16 	# Shift the 'size-1' bits into place [2-]
        and	$17, 31, $17 	# mask out the unwanted bits in arg2 [1]
        and	$16, 31, $16 	# mask out the unwanted bits in arg1 [1]
/* arg1 has size-1, arg2 has position. */
        ldl	$2, 0($12)	# get arg1 tag/data [0di]
        ldl	$1, 4($12)	#  [1]
        extll	$2, 0, $2 	# [2di]
        subq	$1, TypePhysicalAddress, $3 	# [1]
        and	$3, 63, $3 	# [1]
        beq	$3, PTAGLDBILLOP	# [1]
/* Memory Read Internal */
G15337:
        ldq	$3, PROCESSORSTATE_STACKCACHEBASEVMA($14)	# Base of stack cache [1]
        addq	$2, $14, $5 	# [1-]
        ldl	$4, PROCESSORSTATE_SCOVLIMIT($14)	#  [0di]
        s4addq	$5, $31, $19 	# [1-]
        ldq_u	$18, 0($5)	#  [1di]
        subq	$2, $3, $3 	# Stack cache offset [1-]
        cmpult	$3, $4, $4 	# In range? [1]
        ldl	$19, 0($19)	#  [1-]
        extbl	$18, $5, $18 	# [0di]
        bne	$4, G15339	# [1-]
G15338:
G15345:
        subq	$31, 1, $7 	# t7= -1 [0di]
        addq	$16, 1, $16 	# Size of field [1]
        sll	$18, $17, $4 	# T4= shifted value if PP==0 [1]
        srl	$4, 32, $5 	# T5= shifted value if PP<>0 [2]
        sll	$7, $16, $7 	# Unmask [1]
        cmoveq	$17, $4, $5 	# T5= shifted value [1]
        bic	$5, $7, $3 	# T3= masked value. [2]
        ldq	$9, CACHELINE_NEXTPCDATA($13)	#  [1-]
        ldq	$13, CACHELINE_NEXTCP($13)	#  [1]
        bis	$31, TypeFixnum, $4 	# [1-]
        stl	$3, 0($12)	#  [0di]
        stl	$4, 4($12)	# write the stack cache [1]
        br	$31, CACHEVALID	# [1]
.align 3
PTAGLDBILLOP:
/* Convert stack cache address to VMA */
        ldq	$2, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1]
        ldq	$1, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1]
        subq	$12, $2, $2 	# stack cache base relative offset [2-]
        srl	$2, 3, $2 	# convert byte address to word address [1]
        addq	$2, $1, $1 	# reconstruct VMA [2]
        bis	$31, $2, $20 	# [1]
        bis	$31, 57, $17 	# [1]
	br	$31, ILLEGALOPERAND	# Physical not supported
.align 3
G15339:
        ldq	$4, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1-]
        s8addq	$3, $4, $3 	# reconstruct SCA [3]
        ldl	$19, 0($3)	#  [2]
        ldl	$18, 4($3)	# Read from stack cache [1]
        br	$31, G15338	# [1]
.end DoPTagLdb
/* End of Halfword operand from stack instruction - DoPTagLdb */
.align 5
.globl DoDpb
.ent DoDpb 0
/* Field Extraction instruction - DoDpb */
	.globl DoDpbFP
	.globl DoDpbSP
	.globl DoDpbLP
	.globl DoDpbIM
.align 3
DoDpb:
/* Actually only one entry point, but simulate others for dispatch */
#ifdef TRACING
	.byte 0xA0
	.asciiz "DoDpb"
#endif
.align 3
DoDpbIM:
.align 3
DoDpbSP:
.align 3
DoDpbLP:
.align 3
DoDpbFP:
        srl	$18, 37, $16 	# Shift the 'size-1' bits into place [2-]
        and	$17, 31, $17 	# mask out the unwanted bits in arg2 [1]
        and	$16, 31, $16 	# mask out the unwanted bits in arg1 [1]
/* arg1 has size-1, arg2 has position. */
        ldl	$6, 0($12)	# Get arg2 tag/data [0di]
        ldl	$5, 4($12)	# Get arg2 tag/data [1]
        subq	$12, 8, $12 	# Pop Stack. [1]
        extll	$6, 0, $6 	# [1]
        ldl	$19, 0($12)	# get arg1 tag/data [1di]
        ldl	$18, 4($12)	#  [1]
        extll	$19, 0, $19 	# [2di]
        and	$5, 63, $1 	# Strip off any CDR code bits. [1]
        and	$18, 63, $21 	# Strip off any CDR code bits. [1]
        cmpeq	$1, TypeFixnum, $2 	# [1]
.align 3
G15358:
        beq	$2, G15351	# [1]
/* Here if argument TypeFixnum */
        cmpeq	$21, TypeFixnum, $20 	# [0di]
.align 3
G15355:
        beq	$20, G15348	# [1]
/* Here if argument TypeFixnum */
        subq	$31, 2, $7 	# t7= -2 [0di]
        sll	$7, $16, $7 	# Unmask [1]
        ornot	$31, $7, $5 	# reuse t5 as mask [2]
        bic	$19, $7, $3 	# T3= masked new value. [1]
        sll	$5, $17, $5 	# t5 is the inplace mask [1]
        sll	$3, $17, $4 	# t4 is the shifted field [1]
        bic	$6, $5, $6 	# Clear out existing bits in arg2 field [1]
        bis	$4, $6, $6 	# Put the new bits in [1]
        ldq	$9, CACHELINE_NEXTPCDATA($13)	#  [0di]
        ldq	$13, CACHELINE_NEXTCP($13)	#  [1]
        bis	$31, TypeFixnum, $4 	# [0di]
        stl	$6, 0($12)	#  [1-]
        stl	$4, 4($12)	# write the stack cache [1]
        br	$31, CACHEVALID	# [1]
.align 3
G15352:
.align 3
G15351:
/* Here for all other cases */
.align 3
G15347:
        bis	$31, $5, $21 	# arg6 = tag to dispatch on [1-]
        bis	$31, 1, $18 	# arg3 = stackp [1]
        bis	$31, 2, $16 	# arg1 = instruction arity [1]
        bis	$31, 0, $19 	# arg4 = arithmeticp [1]
	br	$31, NUMERICEXCEPTION
        br	$31, G15349	# [1-]
.align 3
G15348:
        bis	$31, $18, $21 	# arg6 = tag to dispatch on [1-]
        bis	$31, 1, $18 	# arg3 = stackp [1]
        bis	$31, 2, $16 	# arg1 = instruction arity [1]
        bis	$31, 0, $19 	# arg4 = arithmeticp [1]
	br	$31, NUMERICEXCEPTION
.align 3
G15349:
.align 3
G15350:
.end DoDpb
/* End of Halfword operand from stack instruction - DoDpb */
.align 5
.globl DoCharDpb
.ent DoCharDpb 0
/* Field Extraction instruction - DoCharDpb */
	.globl DoCharDpbFP
	.globl DoCharDpbSP
	.globl DoCharDpbLP
	.globl DoCharDpbIM
.align 3
DoCharDpb:
/* Actually only one entry point, but simulate others for dispatch */
#ifdef TRACING
	.byte 0xA0
	.asciiz "DoCharDpb"
#endif
.align 3
DoCharDpbIM:
.align 3
DoCharDpbSP:
.align 3
DoCharDpbLP:
.align 3
DoCharDpbFP:
        srl	$18, 37, $16 	# Shift the 'size-1' bits into place [1]
        and	$17, 31, $17 	# mask out the unwanted bits in arg2 [1]
        and	$16, 31, $16 	# mask out the unwanted bits in arg1 [1]
/* arg1 has size-1, arg2 has position. */
        ldl	$6, 0($12)	# Get arg2 tag/data [0di]
        ldl	$5, 4($12)	# Get arg2 tag/data [1]
        subq	$12, 8, $12 	# Pop Stack. [1]
        extll	$6, 0, $6 	# [1]
        ldl	$19, 0($12)	# get arg1 tag/data [1di]
        ldl	$18, 4($12)	#  [1]
        extll	$19, 0, $19 	# [2di]
        and	$5, 63, $1 	# Strip off any CDR code bits. [1]
        and	$18, 63, $21 	# Strip off any CDR code bits. [1]
        cmpeq	$1, TypeCharacter, $2 	# [1]
.align 3
G15371:
        beq	$2, G15364	# [1]
/* Here if argument TypeCharacter */
        cmpeq	$21, TypeFixnum, $20 	# [0di]
.align 3
G15368:
        beq	$20, G15361	# [1]
/* Here if argument TypeFixnum */
        subq	$31, 2, $7 	# t7= -2 [0di]
        sll	$7, $16, $7 	# Unmask [1]
        ornot	$31, $7, $5 	# reuse t5 as mask [2]
        bic	$19, $7, $3 	# T3= masked new value. [1]
        sll	$5, $17, $5 	# t5 is the inplace mask [1]
        sll	$3, $17, $4 	# t4 is the shifted field [1]
        bic	$6, $5, $6 	# Clear out existing bits in arg2 field [1]
        bis	$4, $6, $6 	# Put the new bits in [1]
        ldq	$9, CACHELINE_NEXTPCDATA($13)	#  [0di]
        ldq	$13, CACHELINE_NEXTCP($13)	#  [1]
        bis	$31, TypeCharacter, $4 	# [0di]
        stl	$6, 0($12)	#  [1-]
        stl	$4, 4($12)	# write the stack cache [1]
        br	$31, CACHEVALID	# [1]
.align 3
G15365:
.align 3
G15364:
/* Here for all other cases */
.align 3
G15360:
        bis	$31, $5, $21 	# arg6 = tag to dispatch on [1-]
        bis	$31, 1, $18 	# arg3 = stackp [1]
        bis	$31, 2, $16 	# arg1 = instruction arity [1]
        bis	$31, 0, $19 	# arg4 = arithmeticp [1]
        bis	$31, 0, $20 	# [1]
        bis	$31, 27, $17 	# [1]
	br	$31, SPAREEXCEPTION
        br	$31, G15362	# [1-]
.align 3
G15361:
        bis	$31, 0, $20 	# [1-]
        bis	$31, 27, $17 	# [1]
	br	$31, ILLEGALOPERAND
.align 3
G15362:
.align 3
G15363:
.end DoCharDpb
/* End of Halfword operand from stack instruction - DoCharDpb */
.align 5
.globl DoPDpb
.ent DoPDpb 0
/* Field Extraction instruction - DoPDpb */
	.globl DoPDpbFP
	.globl DoPDpbSP
	.globl DoPDpbLP
	.globl DoPDpbIM
.align 3
DoPDpb:
/* Actually only one entry point, but simulate others for dispatch */
#ifdef TRACING
	.byte 0xA0
	.asciiz "DoPDpb"
#endif
.align 3
DoPDpbIM:
.align 3
DoPDpbSP:
.align 3
DoPDpbLP:
.align 3
DoPDpbFP:
        srl	$18, 37, $16 	# Shift the 'size-1' bits into place [1]
        and	$17, 31, $17 	# mask out the unwanted bits in arg2 [1]
        and	$16, 31, $16 	# mask out the unwanted bits in arg1 [1]
/* arg1 has size-1, arg2 has position. */
        ldl	$2, 0($12)	# Get arg2 tag/data [0di]
        ldl	$1, 4($12)	# Get arg2 tag/data [1]
        subq	$12, 8, $12 	# Pop Stack. [1]
        extll	$2, 0, $2 	# [1]
        subq	$1, TypePhysicalAddress, $3 	# [1]
        and	$3, 63, $3 	# [1]
        beq	$3, PDPBILLOP	# [1]
        ldl	$19, 0($12)	# get arg1 tag/data [1-]
        ldl	$18, 4($12)	# get arg1 tag/data [1]
        subq	$12, 8, $12 	# Pop Stack. [1]
        extll	$19, 0, $19 	# [1]
/* Memory Read Internal */
G15372:
        ldq	$3, PROCESSORSTATE_STACKCACHEBASEVMA($14)	# Base of stack cache [1-]
        addq	$2, $14, $1 	# [0di]
        ldl	$4, PROCESSORSTATE_SCOVLIMIT($14)	#  [1-]
        s4addq	$1, $31, $6 	# [0di]
        ldq_u	$8, 0($1)	#  [1-]
        subq	$2, $3, $3 	# Stack cache offset [1di]
        cmpult	$3, $4, $4 	# In range? [1]
        ldl	$6, 0($6)	#  [0di]
        extbl	$8, $1, $8 	# [1-]
        bne	$4, G15374	# [0di]
G15373:
        extll	$6, 0, $6 	# [2-]
G15380:
        extll	$6, 0, $6 	# [2]
        and	$18, 63, $1 	# Strip off any CDR code bits. [1]
        cmpeq	$1, TypeFixnum, $23 	# [1]
.align 3
G15387:
        beq	$23, G15382	# [1]
/* Here if argument TypeFixnum */
        subq	$31, 2, $7 	# t7= -2 [0di]
        sll	$7, $16, $7 	# Unmask [1]
        ornot	$31, $7, $5 	# reuse t5 as mask [2]
        bic	$19, $7, $3 	# T3= masked new value. [1]
        sll	$5, $17, $5 	# t5 is the inplace mask [1]
        sll	$3, $17, $4 	# t4 is the shifted field [1]
        bic	$6, $5, $6 	# Clear out existing bits in arg2 field [1]
        bis	$4, $6, $6 	# Put the new bits in [1]
        ldq	$4, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1]
        addq	$2, $14, $3 	# [1-]
        ldl	$23, PROCESSORSTATE_SCOVLIMIT($14)	#  [0di]
        s4addq	$3, $31, $5 	# [1-]
        ldq_u	$1, 0($3)	#  [1di]
        subq	$2, $4, $4 	# Stack cache offset [1-]
        cmpult	$4, $23, $23 	# In range? [1]
        insbl	$8, $3, $4 	# [1]
        mskbl	$1, $3, $1 	# [1]
.align 3
G15384:
        bis	$1, $4, $1 	# [2]
        stq_u	$1, 0($3)	#  [0di]
        stl	$6, 0($5)	#  [1]
        bne	$23, G15383	# J. if in cache [1]
        br	$31, NEXTINSTRUCTION	# [1]
        br	$31, NEXTINSTRUCTION	# [1]
.align 3
G15382:
/* Here for all other cases */
        bis	$31, 0, $20 	# [1-]
        bis	$31, 6, $17 	# [1]
	br	$31, ILLEGALOPERAND
.align 3
G15381:
.align 3
PDPBILLOP:
/* Convert stack cache address to VMA */
        ldq	$2, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1-]
        ldq	$1, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1]
        subq	$12, $2, $2 	# stack cache base relative offset [2-]
        srl	$2, 3, $2 	# convert byte address to word address [1]
        addq	$2, $1, $1 	# reconstruct VMA [2]
        bis	$31, $2, $20 	# [1]
        bis	$31, 57, $17 	# [1]
	br	$31, ILLEGALOPERAND	# Physical not supported
.align 3
G15383:
        ldq	$4, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1-]
.align 3
G15388:
        ldq	$3, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1]
        subq	$2, $4, $4 	# Stack cache offset [2di]
        s8addq	$4, $3, $3 	# reconstruct SCA [1]
        stl	$6, 0($3)	# Store in stack [2]
        stl	$8, 4($3)	# write the stack cache [1]
        br	$31, NEXTINSTRUCTION	# [1]
.align 3
G15374:
        ldq	$4, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1]
        s8addq	$3, $4, $3 	# reconstruct SCA [3]
        ldl	$6, 0($3)	#  [2]
        ldl	$8, 4($3)	# Read from stack cache [1]
        br	$31, G15373	# [1]
.end DoPDpb
/* End of Halfword operand from stack instruction - DoPDpb */
.align 5
.globl DoPTagDpb
.ent DoPTagDpb 0
/* Field Extraction instruction - DoPTagDpb */
	.globl DoPTagDpbFP
	.globl DoPTagDpbSP
	.globl DoPTagDpbLP
	.globl DoPTagDpbIM
.align 3
DoPTagDpb:
/* Actually only one entry point, but simulate others for dispatch */
#ifdef TRACING
	.byte 0xA0
	.asciiz "DoPTagDpb"
#endif
.align 3
DoPTagDpbIM:
.align 3
DoPTagDpbSP:
.align 3
DoPTagDpbLP:
.align 3
DoPTagDpbFP:
        srl	$18, 37, $16 	# Shift the 'size-1' bits into place [1-]
        and	$17, 31, $17 	# mask out the unwanted bits in arg2 [1]
        and	$16, 31, $16 	# mask out the unwanted bits in arg1 [1]
/* arg1 has size-1, arg2 has position. */
        ldl	$2, 0($12)	# Get arg2 tag/data [0di]
        ldl	$1, 4($12)	# Get arg2 tag/data [1]
        subq	$12, 8, $12 	# Pop Stack. [1]
        extll	$2, 0, $2 	# [1]
        subq	$1, TypePhysicalAddress, $3 	# [1]
        and	$3, 63, $3 	# [1]
        beq	$3, PTAGDPBILLOP	# [1]
        ldl	$19, 0($12)	# get arg1 tag/data [1-]
        ldl	$18, 4($12)	# get arg1 tag/data [1]
        subq	$12, 8, $12 	# Pop Stack. [1]
        extll	$19, 0, $19 	# [1]
/* Memory Read Internal */
G15389:
        ldq	$3, PROCESSORSTATE_STACKCACHEBASEVMA($14)	# Base of stack cache [1-]
        addq	$2, $14, $1 	# [0di]
        ldl	$4, PROCESSORSTATE_SCOVLIMIT($14)	#  [1-]
        s4addq	$1, $31, $8 	# [0di]
        ldq_u	$6, 0($1)	#  [1-]
        subq	$2, $3, $3 	# Stack cache offset [1di]
        cmpult	$3, $4, $4 	# In range? [1]
        ldl	$8, 0($8)	#  [0di]
        extbl	$6, $1, $6 	# [1-]
        bne	$4, G15391	# [0di]
G15390:
G15397:
        and	$18, 63, $1 	# Strip off any CDR code bits. [1-]
        cmpeq	$1, TypeFixnum, $23 	# [1]
.align 3
G15404:
        beq	$23, G15399	# [1]
/* Here if argument TypeFixnum */
        subq	$31, 2, $7 	# t7= -2 [0di]
        sll	$7, $16, $7 	# Unmask [1]
        ornot	$31, $7, $5 	# reuse t5 as mask [2]
        bic	$19, $7, $3 	# T3= masked new value. [1]
        sll	$5, $17, $5 	# t5 is the inplace mask [1]
        sll	$3, $17, $4 	# t4 is the shifted field [1]
        bic	$6, $5, $6 	# Clear out existing bits in arg2 field [1]
        bis	$4, $6, $6 	# Put the new bits in [1]
        ldq	$4, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1]
        addq	$2, $14, $3 	# [1-]
        ldl	$23, PROCESSORSTATE_SCOVLIMIT($14)	#  [0di]
        s4addq	$3, $31, $5 	# [1-]
        ldq_u	$1, 0($3)	#  [1di]
        subq	$2, $4, $4 	# Stack cache offset [1-]
        cmpult	$4, $23, $23 	# In range? [1]
        insbl	$6, $3, $4 	# [1]
        mskbl	$1, $3, $1 	# [1]
.align 3
G15401:
        bis	$1, $4, $1 	# [2]
        stq_u	$1, 0($3)	#  [0di]
        stl	$8, 0($5)	#  [1]
        bne	$23, G15400	# J. if in cache [1]
        br	$31, NEXTINSTRUCTION	# [1]
        br	$31, NEXTINSTRUCTION	# [1]
.align 3
G15399:
/* Here for all other cases */
        bis	$31, 0, $20 	# [1-]
        bis	$31, 6, $17 	# [1]
	br	$31, ILLEGALOPERAND
.align 3
G15398:
.align 3
PTAGDPBILLOP:
/* Convert stack cache address to VMA */
        ldq	$2, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1-]
        ldq	$1, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1]
        subq	$12, $2, $2 	# stack cache base relative offset [2-]
        srl	$2, 3, $2 	# convert byte address to word address [1]
        addq	$2, $1, $1 	# reconstruct VMA [2]
        bis	$31, $2, $20 	# [1]
        bis	$31, 57, $17 	# [1]
	br	$31, ILLEGALOPERAND	# Physical not supported
.align 3
G15400:
        ldq	$4, PROCESSORSTATE_STACKCACHEBASEVMA($14)	#  [1-]
.align 3
G15405:
        ldq	$3, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1]
        subq	$2, $4, $4 	# Stack cache offset [2di]
        s8addq	$4, $3, $3 	# reconstruct SCA [1]
        stl	$8, 0($3)	# Store in stack [2]
        stl	$6, 4($3)	# write the stack cache [1]
        br	$31, NEXTINSTRUCTION	# [1]
.align 3
G15391:
        ldq	$4, PROCESSORSTATE_STACKCACHEDATA($14)	#  [1]
        s8addq	$3, $4, $3 	# reconstruct SCA [3]
        ldl	$8, 0($3)	#  [2]
        ldl	$6, 4($3)	# Read from stack cache [1]
        br	$31, G15390	# [1]
.end DoPTagDpb
/* End of Halfword operand from stack instruction - DoPTagDpb */
/* Fin. */


/* End of file automatically generated from ../alpha-emulator/ifunfext.as */
