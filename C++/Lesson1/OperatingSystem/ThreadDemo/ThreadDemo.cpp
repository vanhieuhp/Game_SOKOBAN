#include <Windows.h>
#include <stdio.h>	

void Routine(int* n) {
	printf("%d - %d\n", *n, 1);
	printf("%d - %d\n", *n, 2);
	printf("%d - %d\n", *n, 3);
	printf("%d - %d\n", *n, 4);
	printf("%d - %d\n", *n, 5);

}

int main() {
	int i, P[5]; 
	DWORD Id;
	HANDLE hHandles[5];
	for ( i = 0; i < 5; i++)
	{
		P[i] = i;
		hHandles[i] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)Routine, &P[i], 0, &Id);
		printf("Thread %d was created\n", Id);
	}
	getchar();
	return 0;
}