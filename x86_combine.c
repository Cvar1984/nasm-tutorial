extern void exit(int status);
extern int sum(int a, int b);

void main()
{
	int a = 2;
	int b = 3;
	int ret = sum(a,b);
	exit(ret);
}
