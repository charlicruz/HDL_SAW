/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//VBoxSvr/untitled_folder/carlos ITEFI/MOJO/genera uart_tb_v1/clk_18432.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );
char *ieee_p_3620187407_sub_436351764_3965413181(char *, char *, char *, char *, int );
char *ieee_p_3620187407_sub_767668596_3965413181(char *, char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_767740470_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_3807395815_1878664202_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(42, ng0);

LAB3:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3736);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 3640);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_3807395815_1878664202_p_1(char *t0)
{
    char t9[16];
    char t10[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned char t19;
    unsigned char t20;
    int t21;
    unsigned int t22;
    unsigned char t23;
    unsigned char t24;
    unsigned char t25;
    unsigned char t26;
    char *t27;
    char *t28;

LAB0:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t19 = (t4 == (unsigned char)3);
    if (t19 == 1)
        goto LAB9;

LAB10:    t3 = (unsigned char)0;

LAB11:    if (t3 != 0)
        goto LAB7;

LAB8:
LAB3:    t1 = (t0 + 3656);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(47, ng0);
    t1 = (t0 + 3800);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(48, ng0);
    t1 = (t0 + 2088U);
    t2 = *((char **)t1);
    t1 = (t0 + 6120U);
    t5 = (t0 + 1968U);
    t6 = *((char **)t5);
    t5 = (t0 + 6104U);
    t7 = ieee_p_3620187407_sub_767740470_3965413181(IEEE_P_3620187407, t10, t2, t1, t6, t5);
    t8 = ieee_p_3620187407_sub_436351764_3965413181(IEEE_P_3620187407, t9, t7, t10, 1);
    t11 = (t9 + 12U);
    t12 = *((unsigned int *)t11);
    t13 = (1U * t12);
    t3 = (15U != t13);
    if (t3 == 1)
        goto LAB5;

LAB6:    t14 = (t0 + 3864);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t8, 15U);
    xsi_driver_first_trans_fast(t14);
    goto LAB3;

LAB5:    xsi_size_not_matching(15U, t13, 0);
    goto LAB6;

LAB7:    xsi_set_current_line(50, ng0);
    t5 = (t0 + 1672U);
    t6 = *((char **)t5);
    t21 = (14 - 14);
    t12 = (t21 * -1);
    t13 = (1U * t12);
    t22 = (0 + t13);
    t5 = (t6 + t22);
    t23 = *((unsigned char *)t5);
    t24 = (t23 == (unsigned char)3);
    if (t24 != 0)
        goto LAB12;

LAB14:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 6136U);
    t5 = (t0 + 1968U);
    t6 = *((char **)t5);
    t5 = (t0 + 6104U);
    t7 = ieee_p_3620187407_sub_767740470_3965413181(IEEE_P_3620187407, t9, t2, t1, t6, t5);
    t8 = (t9 + 12U);
    t12 = *((unsigned int *)t8);
    t13 = (1U * t12);
    t3 = (15U != t13);
    if (t3 == 1)
        goto LAB17;

LAB18:    t11 = (t0 + 3864);
    t14 = (t11 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t7, 15U);
    xsi_driver_first_trans_fast(t11);

LAB13:    goto LAB3;

LAB9:    t1 = (t0 + 992U);
    t20 = xsi_signal_has_event(t1);
    t3 = t20;
    goto LAB11;

LAB12:    xsi_set_current_line(51, ng0);
    t7 = (t0 + 1512U);
    t8 = *((char **)t7);
    t25 = *((unsigned char *)t8);
    t26 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t25);
    t7 = (t0 + 3800);
    t11 = (t7 + 56U);
    t14 = *((char **)t11);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = t26;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 6136U);
    t5 = (t0 + 2088U);
    t6 = *((char **)t5);
    t5 = (t0 + 6120U);
    t7 = ieee_p_3620187407_sub_767668596_3965413181(IEEE_P_3620187407, t10, t2, t1, t6, t5);
    t8 = (t0 + 1968U);
    t11 = *((char **)t8);
    t8 = (t0 + 6104U);
    t14 = ieee_p_3620187407_sub_767740470_3965413181(IEEE_P_3620187407, t9, t7, t10, t11, t8);
    t15 = (t9 + 12U);
    t12 = *((unsigned int *)t15);
    t13 = (1U * t12);
    t3 = (15U != t13);
    if (t3 == 1)
        goto LAB15;

LAB16:    t16 = (t0 + 3864);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t27 = (t18 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t14, 15U);
    xsi_driver_first_trans_fast(t16);
    goto LAB13;

LAB15:    xsi_size_not_matching(15U, t13, 0);
    goto LAB16;

LAB17:    xsi_size_not_matching(15U, t13, 0);
    goto LAB18;

}


extern void work_a_3807395815_1878664202_init()
{
	static char *pe[] = {(void *)work_a_3807395815_1878664202_p_0,(void *)work_a_3807395815_1878664202_p_1};
	xsi_register_didat("work_a_3807395815_1878664202", "isim/tb_isim_beh.exe.sim/work/a_3807395815_1878664202.didat");
	xsi_register_executes(pe);
}
