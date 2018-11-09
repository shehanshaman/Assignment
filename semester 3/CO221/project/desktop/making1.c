//gtypistl - typespeed

#include <stdio.h>

void print(int n,int array[]){
	int i;
	for(i=0;i<n;i++){
		printf("%d ",array[i]);
	}
	printf("\n");
}
int max(int n,int array[]){
	int max=0,i,in;
	//find max number
	for(i=0;i<n;i++){
		in = array[i];
		if(max<in){
			max=in;
		}
	}
	return max;
}

int main (){
	
	int n,i,in,maxnum;
	
	printf("How many numbers are you enter : ");
	scanf("%d",&n);
	int inputs[n];
	for(i=0;i<n;i++){
		scanf("%d",&in);
		inputs[i]=in;
	}
	//print(n,inputs);
	maxnum=  max(n,inputs);
	//printf("max number : %d\n",maxnum);
	
	int count=0,k=0,j,prime[50];
	for(i=1;i<=maxnum;i++){
		for(j=1;j<=i;j++){
			
			if(i%j==0){
				count++;
			}
		}
		if(count == 2){
			prime[k] = i;
			k++;
		}
		count = 0;
		
	}
	//printf("Prime number up to max number : ");
	//print(k,prime);
	
	count = 0;
	int tnum;
	int power[40]={};
	
	for(i=0;i<n;i++){
		tnum = inputs[i];
		for(j=0;j<k;j++){
			while(tnum%prime[j]==0){
				count++;
				tnum = tnum/prime[j];
			}
			if(power[j]<count){
				power[j]=count;
			}
			//printf("%d\n",count);
			count=0;
		}
	}
	//print(k,prime);
	//print(k,power);
	int out=1,x=1;
	for(i=0;i<k;i++){
		for(j=1;j<=power[i];j++){
			x = x*prime[i];
		}if(x>1){
			out = out * x;
			//printf("%d\n",out);
			x=1;
		}
	}
	printf("Least count multiplyier = %d\n",out);
	return 0;
}
