#include <iostream>
#include <unistd.h> 

// Recursive 
int rFibonacci(int n){
    if(n <= 1) return n;
    else return rFibonacci(n-1) + rFibonacci(n-2);
}

// Non Recursive
int nrFibonacci(int n){
    int fib = 0, a = 0, b = 1;
    if(n == 0) return n;
    for(int i=1; i<n; i++){
        fib = a + b;
        a = b;
        b = fib;
    }
    return fib;
}

// DP Fibonacci
int dp[100];
int dpFibonacci(int n){
    if(dp[n] != 0) return dp[n];
    if(n < 2) return n;
    else return dpFibonacci(n-1) + dpFibonacci(n-2);
}



int main(){

    printf(" rFibonacci: %d\r\n", rFibonacci(9));
    printf("nrFibonacci: %d\r\n", nrFibonacci(9));
    printf("dpFibonacci: %d\r\n", dpFibonacci(9));
    return 0;
    
}