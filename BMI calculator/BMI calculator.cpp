#include <iostream>
#include <unistd.h> 

int bmi(int height, int weight){
    return (weight * 10000) / (height * height);
}

void level(int n){
    if(n < 19){
        printf("Under Weight ");
    }else if(n>= 19 && n < 24){
        printf("Standard ");
    }else{
        printf("Over Weight ");
    }
    printf(" BMI: %d", n);
}


int main(){
    int h=0, w=0;
    printf("Input Height: ");
    scanf("%d", &h);
    printf("Input Weight: ");
    scanf("%d", &w);
    level(bmi(h, w));

}