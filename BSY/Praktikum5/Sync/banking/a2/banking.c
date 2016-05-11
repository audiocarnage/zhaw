//******************************************************************************
// Course:  BSy
// File:    banking.c
// Author:  M. Thaler, ZHAW
// Purpose: locking mechanisms
// Version: v.fs16
//******************************************************************************

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <pthread.h>

#include "banking.h"

//******************************************************************************

typedef struct account_struct_ {
    long account;
    pthread_mutex_t a_lock;
} account;

typedef struct branch_struct {
    account *Accounts;
    pthread_mutex_t b_lock; 
} theBranch;

//******************************************************************************

static theBranch *Bank;
static int nBranches, nAccounts;

//******************************************************************************
// banking functions

void makeBank(int num_branches, int num_accounts) {
    nBranches = num_branches;
    nAccounts = num_accounts;
    Bank = (theBranch *)malloc(nBranches * sizeof(theBranch));

    pthread_mutexattr_t attr;
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE_NP);
    pthread_mutexattr_init(&attr);

    for (int  i = 0; i < nBranches; i++) {
        Bank[i].Accounts = (account *)malloc(nAccounts * sizeof(account));
        pthread_mutex_init(&(Bank[i].b_lock), &attr);
        for (int j = 0; j < nAccounts; j++) {
            Bank[i].Accounts[j].account = 0;
            pthread_mutex_init((&(Bank[i].Accounts[j].a_lock)), &attr);
        }
    }
}

void deleteBank(void) {
    for (int i = 0; i < nBranches; i++)
        free(Bank[i].Accounts);
    free(Bank);
    nBranches = nAccounts = 0;
}

long withdraw(int branch, int account, long value) {
    int rv, tmp;
    rv = 0;
    pthread_mutex_lock(&(Bank[branch].b_lock));
    //pthread_mutex_lock(&(Bank[branch].Accounts[account].a_lock));
    tmp = Bank[branch].Accounts[account].account - value;
    if (tmp >= 0) {
        Bank[branch].Accounts[account].account = tmp;
        rv = value;
    }
    //pthread_mutex_unlock(&(Bank[branch].Accounts[account].a_lock));
    pthread_mutex_unlock(&(Bank[branch].b_lock));
    return rv;
}

void deposit(int branch, int account, long value) {
    pthread_mutex_lock(&(Bank[branch].b_lock));
    //pthread_mutex_lock(&(Bank[branch].Accounts[account].a_lock));
    Bank[branch].Accounts[account].account += value;
    //pthread_mutex_unlock(&(Bank[branch].Accounts[account].a_lock));
    pthread_mutex_unlock(&(Bank[branch].b_lock));
}

void transfer(int fromB, int toB, int account, long value) {
    int money = withdraw(fromB, account, value);
    if (money > 0)
        deposit(toB, account, money);
}

void checkAssets(void) {
    static long assets = 0;
    long sum = 0;
    for (int i = 0; i < nBranches; i++) {
        for (int j = 0; j < nAccounts; j++) {
            sum += (long)Bank[i].Accounts[j].account;
        }
    }
    if (assets == 0) {
        assets = sum;
        printf("Balance of accounts is: %ld\n", sum);
    }
    else {
        if (sum != assets)
            printf("Balance of accounts is: %ld ... not correct\n", sum);
        else
            printf("Balance of accounts is: %ld ... correct\n", assets);
    }
}

//******************************************************************************

