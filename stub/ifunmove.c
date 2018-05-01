/************************************************************************
 * WARNING: DO NOT EDIT THIS FILE.  THIS FILE WAS AUTOMATICALLY GENERATED
 * FROM ../alpha-emulator/ifunmove.as. ANY CHANGES MADE TO THIS FILE WILL BE LOST
 ************************************************************************/

  /* Data movement. */
/* start DoPushNNils */

  /* Halfword operand from stack instruction - DoPushNNils */
  /* arg2 has the preloaded 8 bit operand. */

dopushnnils:
  if (_trace) printf("dopushnnils:\n");
#ifdef TRACING
#endif

DoPushNNilsSP:
  if (_trace) printf("DoPushNNilsSP:\n");
  /* Assume SP mode */
  arg1 = arg5;
  /* SP-pop mode */
  if (arg2 == 0)
    arg1 = iSP;
  /* Adjust SP if SP-pop mode */
  if (arg2 == 0)
    iSP = arg4;
#ifdef TRACING
  goto headdopushnnils;
#endif

DoPushNNilsLP:
  if (_trace) printf("DoPushNNilsLP:\n");
#ifdef TRACING
  goto headdopushnnils;
#endif

DoPushNNilsFP:
  if (_trace) printf("DoPushNNilsFP:\n");

headdopushnnils:
  if (_trace) printf("headdopushnnils:\n");
  /* Compute operand address */
  arg1 = (arg2 * 8) + arg1;
  /* Get the operand */
  arg1 = *(u64 *)arg1;

begindopushnnils:
  if (_trace) printf("begindopushnnils:\n");
  /* arg1 has the operand, not sign extended if immediate. */
  /* Get the data */
  arg2 = (u32)arg1;
  /* and the tag */
  t1 = arg1 >> 32;
  t5 = t1 - Type_Fixnum;
  /* Strip CDR code */
  t5 = t5 & 63;
  if (t5 != 0)
    goto pushnnbadop;
#ifdef TRACING
  goto DoPushNNilsIM;
#endif

DoPushNNilsIM:
  if (_trace) printf("DoPushNNilsIM:\n");
  /* Current stack cache limit (words) */
  t4 = *(s32 *)&processor->scovlimit;
  t1 = zero + 128;
  /* Alpha base of stack cache */
  t2 = *(u64 *)&(processor->stackcachedata);
  /* Account for what we're about to push */
  t1 = t1 + arg2;
  /* SCA of desired end of cache */
  t1 = (t1 * 8) + iSP;
  /* SCA of current end of cache */
  t2 = (t4 * 8) + t2;
  t4 = ((s64)t1 <= (s64)t2) ? 1 : 0;
  /* We're done if new SCA is within bounds */
  if (t4 == 0)
    goto stackcacheoverflowhandler;
  arg6 = *(u64 *)&(processor->niladdress);
  goto pushnnilsl2;

pushnnilsl1:
  if (_trace) printf("pushnnilsl1:\n");
  /* Push NIL */
  *(u64 *)(iSP + 8) = arg6;
  iSP = iSP + 8;
  arg2 = arg2 - 1;

pushnnilsl2:
  if ((s64)arg2 > 0)
    goto pushnnilsl1;
  goto NEXTINSTRUCTION;

pushnnbadop:
  if (_trace) printf("pushnnbadop:\n");
  arg5 = 0;
  arg2 = 63;
  goto illegaloperand;

/* end DoPushNNils */
  /* End of Halfword operand from stack instruction - DoPushNNils */
/* start DoPushAddressSpRelative */

  /* Halfword operand from stack instruction - DoPushAddressSpRelative */
  /* arg2 has the preloaded 8 bit operand. */

dopushaddresssprelative:
  if (_trace) printf("dopushaddresssprelative:\n");
#ifdef TRACING
#endif

DoPushAddressSpRelativeIM:
  if (_trace) printf("DoPushAddressSpRelativeIM:\n");
  /* This sequence is lukewarm */
  *(u32 *)&processor->immediate_arg = arg2;
  arg1 = *(u64 *)&(processor->immediate_arg);
  goto begindopushaddresssprelative;
#ifdef TRACING
#endif

DoPushAddressSpRelativeSP:
  if (_trace) printf("DoPushAddressSpRelativeSP:\n");
  /* Assume SP mode */
  arg1 = arg5;
  /* SP-pop mode */
  if (arg2 == 0)
    arg1 = iSP;
  /* Adjust SP if SP-pop mode */
  if (arg2 == 0)
    iSP = arg4;
#ifdef TRACING
  goto headdopushaddresssprelative;
#endif

DoPushAddressSpRelativeLP:
  if (_trace) printf("DoPushAddressSpRelativeLP:\n");
#ifdef TRACING
  goto headdopushaddresssprelative;
#endif

DoPushAddressSpRelativeFP:
  if (_trace) printf("DoPushAddressSpRelativeFP:\n");

headdopushaddresssprelative:
  if (_trace) printf("headdopushaddresssprelative:\n");
  /* Compute operand address */
  arg1 = (arg2 * 8) + arg1;
  /* Get the operand */
  arg1 = *(u64 *)arg1;

begindopushaddresssprelative:
  if (_trace) printf("begindopushaddresssprelative:\n");
  /* arg1 has the operand, not sign extended if immediate. */
  /* SP before any popping */
  t4 = *(u64 *)&(processor->restartsp);
  t1 = arg1 >> 32;
  arg1 = (u32)arg1;
  /* Base of the stack cache */
  t6 = *(u64 *)&(processor->stackcachebasevma);
  /* THe stack cache data block */
  t7 = *(u64 *)&(processor->stackcachedata);
  /* Strip off any CDR code bits. */
  t2 = t1 & 63;
  t3 = (t2 == Type_Fixnum) ? 1 : 0;

g7983:
  if (_trace) printf("g7983:\n");
  if (t3 == 0)
    goto g7980;
  /* Here if argument TypeFixnum */
  arg1 = (arg1 * 8) + 8;
  /* Compute stack relative pointer */
  t5 = t4 - arg1;
  /* Index into stack data */
  t5 = t5 - t7;
  /* Convert to word index */
  t5 = t5 >> 3;
  /* Convert to an ivory word address */
  t5 = t6 + t5;
  iPC = *(u64 *)&(((CACHELINEP)iCP)->nextpcdata);
  iCP = *(u64 *)&(((CACHELINEP)iCP)->nextcp);
  t6 = Type_Locative;
  *(u32 *)(iSP + 8) = t5;
  /* write the stack cache */
  *(u32 *)(iSP + 12) = t6;
  iSP = iSP + 8;
  goto cachevalid;

g7980:
  if (_trace) printf("g7980:\n");
  /* Here for all other cases */
  arg5 = 0;
  arg2 = 63;
  goto illegaloperand;

g7979:
  if (_trace) printf("g7979:\n");

/* end DoPushAddressSpRelative */
  /* End of Halfword operand from stack instruction - DoPushAddressSpRelative */
/* start DoStackBlt */

  /* Halfword operand from stack instruction - DoStackBlt */
  /* arg2 has the preloaded 8 bit operand. */

dostackblt:
  if (_trace) printf("dostackblt:\n");
#ifdef TRACING
#endif

DoStackBltIM:
  if (_trace) printf("DoStackBltIM:\n");
  /* This sequence is lukewarm */
  *(u32 *)&processor->immediate_arg = arg2;
  arg1 = *(u64 *)&(processor->immediate_arg);
  goto begindostackblt;
#ifdef TRACING
#endif

DoStackBltSP:
  if (_trace) printf("DoStackBltSP:\n");
  /* Assume SP mode */
  arg1 = arg5;
  /* SP-pop mode */
  if (arg2 == 0)
    arg1 = iSP;
  /* Adjust SP if SP-pop mode */
  if (arg2 == 0)
    iSP = arg4;
#ifdef TRACING
  goto headdostackblt;
#endif

DoStackBltLP:
  if (_trace) printf("DoStackBltLP:\n");
#ifdef TRACING
  goto headdostackblt;
#endif

DoStackBltFP:
  if (_trace) printf("DoStackBltFP:\n");

headdostackblt:
  if (_trace) printf("headdostackblt:\n");
  /* Compute operand address */
  arg1 = (arg2 * 8) + arg1;
  /* Get the operand */
  arg1 = *(u64 *)arg1;

begindostackblt:
  if (_trace) printf("begindostackblt:\n");
  /* arg1 has the operand, not sign extended if immediate. */
  /* Destination locative */
  t3 = *(s32 *)iSP;
  /* Destination locative */
  t2 = *(s32 *)(iSP + 4);
  /* Pop Stack. */
  iSP = iSP - 8;
  t3 = (u32)t3;
  t1 = (u32)arg1;
  /* Convert VMA to stack cache address */
  t4 = *(u64 *)&(processor->stackcachebasevma);
  arg1 = *(u64 *)&(processor->stackcachedata);
  /* stack cache base relative offset */
  t4 = t1 - t4;
  /* reconstruct SCA */
  arg1 = (t4 * 8) + arg1;
  /* Base of the stack cache */
  t4 = *(u64 *)&(processor->stackcachebasevma);
  /* End ofthe stack cache */
  t5 = *(u64 *)&(processor->stackcachetopvma);
  /* THe stack cache data block */
  t1 = *(u64 *)&(processor->stackcachedata);
  /* BAse of Stack Cache. */
  t6 = t3 - t4;
  /* Top of Stack Cache. */
  t7 = t3 - t5;
  /* J. if vma below stack cache */
  if ((s64)t6 < 0)
    goto stkbltexc;
  /* J. if vma above stack cache */
  if ((s64)t7 >= 0)
    goto stkbltexc;
  /* Compute the stackcache address */
  t6 = (t6 * 8) + t1;
  goto stkbltloopend;

stkbltloop:
  if (_trace) printf("stkbltloop:\n");
  /* Advance Source */
  arg1 = arg1 + 8;
  /* Advance destination */
  t6 = t6 + 8;

stkbltloopend:
  /* Read a word from the source */
  t1 = *(u64 *)arg1;
  t4 = arg1 - iSP;
  /* copy the word */
  *(u64 *)t6 = t1;
  /* J. if sourse not stack top */
  if (t4 != 0)
    goto stkbltloop;
  /* Update the SP to point at the last written location */
  iSP = t6;
  goto NEXTINSTRUCTION;

stkbltexc:
  if (_trace) printf("stkbltexc:\n");
  arg5 = 0;
  arg2 = 73;
  goto illegaloperand;

/* end DoStackBlt */
  /* End of Halfword operand from stack instruction - DoStackBlt */
/* start DoStackBltAddress */

  /* Halfword operand from stack instruction - DoStackBltAddress */
  /* arg2 has the preloaded 8 bit operand. */

dostackbltaddress:
  if (_trace) printf("dostackbltaddress:\n");
#ifdef TRACING
#endif

DoStackBltAddressSP:
  if (_trace) printf("DoStackBltAddressSP:\n");
  /* Assume SP mode */
  arg1 = arg5;
  /* SP-pop mode */
  if (arg2 == 0)
    arg1 = iSP;
  /* Adjust SP if SP-pop mode */
  if (arg2 == 0)
    iSP = arg4;
#ifdef TRACING
  goto begindostackbltaddress;
#endif

DoStackBltAddressLP:
  if (_trace) printf("DoStackBltAddressLP:\n");
#ifdef TRACING
  goto begindostackbltaddress;
#endif

DoStackBltAddressFP:
  if (_trace) printf("DoStackBltAddressFP:\n");

begindostackbltaddress:
  if (_trace) printf("begindostackbltaddress:\n");
  /* arg1 has the operand address. */
  /* Compute operand address */
  arg1 = (arg2 * 8) + arg1;
  /* Destination locative */
  t3 = *(s32 *)iSP;
  /* Destination locative */
  t2 = *(s32 *)(iSP + 4);
  /* Pop Stack. */
  iSP = iSP - 8;
  t3 = (u32)t3;
  /* Base of the stack cache */
  t4 = *(u64 *)&(processor->stackcachebasevma);
  /* End ofthe stack cache */
  t5 = *(u64 *)&(processor->stackcachetopvma);
  /* THe stack cache data block */
  t1 = *(u64 *)&(processor->stackcachedata);
  /* Base of Stack Cache. */
  t6 = t3 - t4;
  /* Top of Stack Cache. */
  t7 = t3 - t5;
  /* J. if vma below stack cache */
  if ((s64)t6 < 0)
    goto stkbltadrexc;
  /* J. if vma above stack cache */
  if ((s64)t7 >= 0)
    goto stkbltadrexc;
  /* Compute the stackcache address */
  t6 = (t6 * 8) + t1;
  goto stkbltaddloopend;

stkbltaddloop:
  if (_trace) printf("stkbltaddloop:\n");
  /* Advance Source */
  arg1 = arg1 + 8;
  /* Advance destination */
  t6 = t6 + 8;

stkbltaddloopend:
  /* Read a word from the source */
  t1 = *(u64 *)arg1;
  t4 = arg1 - iSP;
  /* copy the word */
  *(u64 *)t6 = t1;
  /* J. if sourse not stack top */
  if (t4 != 0)
    goto stkbltaddloop;
  /* Update the SP to point at the last written location */
  iSP = t6;
  goto NEXTINSTRUCTION;

stkbltadrexc:
  if (_trace) printf("stkbltadrexc:\n");
  arg5 = 0;
  arg2 = 73;
  goto illegaloperand;
#ifdef TRACING
#endif

DoStackBltAddressIM:
  goto doistageerror;

/* end DoStackBltAddress */
  /* End of Halfword operand from stack instruction - DoStackBltAddress */
  /* Fin. */



/* End of file automatically generated from ../alpha-emulator/ifunmove.as */