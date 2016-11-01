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

int  withdraw(int branch, int account, int value) ;
int  deposit(int branch, int account, int value);
void transfer(int fromB, int toB, int account, int value);
void checkAssets(void);

//******************************************************************************

