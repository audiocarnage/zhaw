//******************************************************************************
// Course:  BSy
// File:    banking.h
// Author:  M. Thaler, ZHAW
// Purpose: locking mechanisms
// Version: v.fs16
//******************************************************************************
// banking functions

void makeBank(int num_branches, int num_accounts);
void deleteBank(void);

long withdraw(int branch, int account, long value) ;
void deposit(int branch, int account, long value);
void transfer(int fromB, int toB, int account, int long);
void checkAssets(void);

//******************************************************************************

