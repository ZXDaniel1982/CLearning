#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <stdbool.h>
#include <stdarg.h>
#include <errno.h>
#include <unistd.h>

#include "Lesson.h"

#define N 20

#define STR_CONCAT(a, b) a##b

#define showlist(...) printf(#__VA_ARGS__)
#define report(test, ...) ((test)?printf(#test):\
            printf(__VA_ARGS__))

typedef struct Point {
    double x;
    double y;
} tPoint;

const double pi = 3.1416;

static int valA = 15;
static int valB = 90;

double getRadius(tPoint point1, tPoint point2)
{
    double radiusNum = 0;

    radiusNum =
        sqrt(pow((point2.x - point1.x), 2) +
             pow((point2.y - point1.y), 2));
    printf("radiusNum is %f\n", radiusNum);
    return radiusNum;
}

double getArea(double radiusNum)
{
    double areaNum = 0;

    areaNum = pi * pow(radiusNum, 2);
    printf("areaNum is %f\n", areaNum);
    return areaNum;
}

int Fibonacci(int n)
{
    int ret = 0;

    if (n < 0) {
        ret = -1;
    } else if (n == 0) {
        ret = 0;
    } else if (n == 1) {
        ret = 1;
    } else {
        ret = Fibonacci(n - 1) + Fibonacci(n - 2);
    }
    return ret;
}

int FibonacciLoop(int n)
{
    int ret = 0;
    int fn1 = 0, fn2 = 1;

    if (n < 2)
        return n;
    else {
        while (n >= 2) {
            ret = fn1 + fn2;
            fn1 = fn2;
            fn2 = ret;
            n--;
        }
        return ret;
    }
}

int *printRandom(int upperBand)
{
    int *a;
    int i;

    a = malloc(N * sizeof(int));

    for (i = 0; i < N; i++) {
        *(a + i) = rand() % upperBand;
    }

    return a;
}

void GestureGame(int man)
{
    static const char gesture[3][10] = {
        "scissor", "stone", "cloth"
    };
    int computer = 0, ran = 0, diff = 0;
    int i;

    printf("\n");
    if ((man < 0) || (man > 2)) {
        printf("Invalid input gesture\n");
        return;
    } else {
        printf("Input gesture is %s\n", gesture[man]);
    }
    // Generate new random values every time
    srand((unsigned) time(NULL));
    for (i = 0; i < 5; i++) {
        printf("Random number is %d\n", ran = rand());
        computer = ran % 3;
        if (man == computer) {
            printf("Equal man=%s computer=%s\n", gesture[man],
                   gesture[computer]);
        } else {
            diff = (man - computer + 2) % 3;
            if (diff == 0)
                printf("Win man=%s computer=%s\n",
                       gesture[man], gesture[computer]);
            else
                printf("Loss man=%s computer=%s\n",
                       gesture[man], gesture[computer]);
        }
    }
    return;
}

void LowToHighInsert()
{
    int a[10];
    int b[10];
    int cost = 0, key;
    int i, j;

    memset(b, 11, sizeof(int) * 10);

    printf("Generateing random array ...\n");
    for (i = 0; i < 10; i++) {
        a[i] = rand() % 10 + 1;
        printf("%d ", a[i]);
    }
    printf("\n");

    for (i = 0; i < 10; i++) {
        for (j = i; j >= 0; j--) {
            if (a[i] < b[j]) {
                cost++;
                if (i < 9)
                    b[j + 1] = b[j];
                b[j] = a[i];
            } else {
                break;
            }
        }
    }

    printf("The result array ...\n");
    for (i = 0; i < 10; i++) {
        printf("%d ", b[i]);
    }
    printf("\n");
    printf("The total cost is %d\n\n", cost);

    cost = 0;
    for (i = 1; i < 10; i++) {
        int j;
        key = a[i];
        j = i - 1;
        while (j >= 0 && a[j] > key) {
            a[j + 1] = a[j];
            j--;
            cost++;
        }
        a[j + 1] = key;
    }

    printf("The result array ...\n");
    for (i = 0; i < 10; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
    printf("The total cost is %d\n", cost);
}

#define LOWERTOHIGH_MERGE_LEN 8

/*
void LowToHighMerge(void)
{
    int a[10];
    int mid, end;

    end = 10;
    mid = end/10;

    printf("Generateing random array ...\n");
    printf("sort (0 ~ %d, %d ~ %d)\n", mid, mid + 1, end);
    for (int i = 0; i < 10; i++) {
        a[i] = rand() % 10 + 1;
        print("%d ", a[i]);
    }
    printf("\n");

} */

void Algorithm(void)
{
    LowToHighInsert();
    // LowToHighMerge();
}

bool isEmpty(int count)
{
    if (count == 0) {
        return true;
    } else {
        return false;
    }
}

void StackSim(void)
{
    char stack[128];
    int count = 0;

    PushSim('a', count, stack);
    PushSim('b', count, stack);
    PushSim('c', count, stack);

    while (!isEmpty(count)) {
        PopSim(count, stack);
    }
}

void TypeConversion()
{
    unsigned char c1 = 255, c2 = 2;
    unsigned char cOverflow;
    int cConvert;

    unsigned int i1 = 5;
    int i2 = -3;

    cOverflow = c1 + c2;
    cConvert = c1 + c2;

    printf("char overflow is %d convert is %d\n", cOverflow, cConvert);


    printf("int convert is %d\n", i1 + i2);
}

void BitOper()
{
    unsigned int uInput;
    int iInput;

    uInput = 5;
    iInput = -5;
    printf("unsigned bit oper right %x, signed bit oper right %x\n",
           (uInput >> 2), (iInput >> 2));
    printf("unsigned bit oper left %x, signed bit oper left %x\n",
           (uInput << 2), (iInput << 2));

    iInput = -1610612737;
    // result 2147483644 7ffffffc
    printf("signed bit %d %x oper right %d %x\n", iInput, iInput,
           (iInput << 2), (iInput << 2));

    iInput = 0xcffffff3;
    printf("%x\n", (0xcffffff3 >> 2));
    printf("%x\n", iInput >> 2);

    iInput = 15;
    uInput = 25;

    iInput ^= uInput;
    uInput ^= iInput;
    iInput ^= uInput;

    printf("iInput is %d, uInput is %d\n", iInput, uInput);
}

void BitField()
{
    typedef union {
        struct {
            unsigned int one:1;
            unsigned int two:3;
            unsigned int three:10;
            unsigned int four:5;
            unsigned int:2;
            unsigned int five:8;
            unsigned int six:8;
        } bitfield;
        unsigned char byte[8];
    } demo_type;

    demo_type u = { {1, 5, 513, 17, 129, 0x81} };

    printf("sizeof demo_type = %lu\n", sizeof(demo_type));
    printf("values : u=%u,%u,%u,%u,%u,%u\n", u.bitfield.one,
           u.bitfield.two, u.bitfield.three, u.bitfield.four,
           u.bitfield.five, u.bitfield.six);
    printf("hex dump of u: %x %x %x %x %x %x %x %x\n", u.byte[0],
           u.byte[1], u.byte[2], u.byte[3], u.byte[4], u.byte[5],
           u.byte[6], u.byte[7]);
}

void SizeAndType()
{
    typedef char array_t[10];
    int a[12];
    array_t b;

    printf("The number of a list is %lu\n", sizeof a / sizeof a[0]);
    printf("The number of b list is %lu\n", sizeof b / sizeof b[0]);
}

void Variates()
{
    static int valA = 23;
    int valB = 89;

    printf("valA is %d, valB is %d\n", valA++, valB++);
}

/*  ===========================================================================
 *  Complex macro defines
 */

#define DISPALY(a) Display##a
#define INITVAL 20
#define f(a) (INITVAL + a)
#undef INITVAL
#define INITVAL 40

#define DEVICE_TYPE 1
#if DEVICE_TYPE == 1
#define TYPENAME "It is PC"
#elif DEVICE_TYPE == 2
#define TYPENAME "It is embedded"
#else
#error UNKNOWN TARGET MACHINE
#endif

void Displaybook()
{
    printf("This is a book\n");
}

void Displayname()
{
    printf("This is a name\n");
}

void ComplexDefine()
{
    char book1[] = "Lord of rings";
    char book2[] = "Harry Porter";
    int x = 102, y = 89;

    printf("book1 is %s, book2 is %s\n", STR_CONCAT(book, 1),
           STR_CONCAT(book, 2));

    showlist(The first, second, and third items.);
    printf("\n");
    report(x > y, "x is %d but y is %d", x, y);
    printf("\n");

    DISPALY(book) ();
    DISPALY(name) ();

    printf("val is %d\n", f(x));        // INITVAL = 40

    printf("DEVICE_TYPE is %s\n", TYPENAME);
}

/*  ===========================================================================
 *  Melloc free and doule pointers
 */

typedef struct {
    int number;
    char *msg;
} unit_t;

void alloc_unit(unit_t ** pp)
{
    unit_t *p = malloc(sizeof(unit_t));

    if (p == NULL) {
        printf("Out of memory\n");
        return;
    }

    p->number = 3;
    p->msg = malloc(sizeof(char) * 20);
    strncpy(p->msg, "Another malloc", 20);
    *pp = p;
}

void free_unit(unit_t * p)
{
    free(p->msg);
    free(p);
}

void DynamicApp()
{
    unit_t *p = malloc(sizeof(unit_t));
    unit_t *ptr = NULL;

    if (p == NULL) {
        printf("Out of memory\n");
        return;
    }

    p->number = 3;
    p->msg = malloc(sizeof(char) * 20);
    strncpy(p->msg, "Hello malloc", 20);
    printf("p.number is %d, p.msg is %s\n", p->number, p->msg);

    free(p->msg);
    free(p);
    p = NULL;

    alloc_unit(&ptr);
    printf("p.number is %d, p.msg is %s\n", ptr->number, ptr->msg);
    free_unit(ptr);
    ptr = NULL;
}

/*  ===========================================================================
 *  getaday(0) and getaday(1) are returning pointers to ONE location and
 *  getaday(0) is overwrited by getaday(1)
 */
static const char *msg[] = { "Sunday", "Monday", "Tuesday", "Wednesday" };

char *getaday(int idx)
{
    static char buf[20];

    printf("idx is %d, msg is %s\n", idx, msg[idx]);
    strcpy(buf, msg[idx]);
    return buf;
}

void errorPrint()
{
    printf("%s %s\n", getaday(0), getaday(1));
}

/*  ===========================================================================
 *  Format input
 */
void myprintf(const char *format, ...)
{
    va_list ap;
    char c;
    char ch;
    char *p;

    va_start(ap, format);
    while (c = *format++) {
        switch (c) {
        case 'c':
            ch = va_arg(ap, int);
            putchar(ch);
            break;
        case 's':
            p = va_arg(ap, char *);
            fputs(p, stdout);
            break;
        default:
            putchar(c);
            break;
        }
    }

    va_end(ap);
}

void FormatInput()
{
    myprintf("c\ts\n", '1', "Hello");
}

/*  ===========================================================================
 *  Test memmove
 */
void StringFunctions()
{
    char str[255];
    char tokstr[255];
    char *token;
#if 0
    String initialization functions *memset
#endif
     memset(str, 0, sizeof(str));

#if 0
    String copy functions *strcpy * strncpy * memcpy * memmove
#endif
     strncpy(str, "Hello worldd", sizeof(str));
    printf("memmove start with %s\n", str);
    memmove(str + 1, str, 11);
    printf("memmove end with %s\n", str);

#if 0
    String length functions *strlen
#endif
     printf("str %s len is %u\n", str, (unsigned int) strlen(str));

#if 0
    String joint functions *strcat * strncat
#endif
     printf("strcat start with %s\n", str);
    strcat(str, ". I dont like it");
    printf("strcat end with %s\n", str);

#if 0
    String compare functions *memcmp * strcmp * strncmp
#endif
     printf("str cmp with 5 of HHella is %d\n", strncmp(str, "HHella", 5));
    printf("str cmp with 6 of HHella is %d\n", strncmp(str, "HHella", 6));

#if 0
    String search functions *strchr * srttchr * strstr
#endif
     printf("strchr of o is %s\n", strchr(str, 'o'));
    printf("strrchr of o is %s\n", strrchr(str, 'o'));
    printf("strstr of orl is %s\n", strstr(str, "orl"));

#if 0
    String seperate functions *strtok * strtok_r * strstr
#endif
     strncpy(tokstr, str, sizeof(tokstr));
    token = strtok(tokstr, "o");
    printf("first token is %s\n", token);
    while ((token = strtok(NULL, "o")) != NULL) {
        printf("%s\n", token);
    }
}

/*  ===========================================================================
 *  File operations
 */
#define MAXLINE 80
void err_sys(const char *fmt, ...)
{
    int err = errno;
    char buf[MAXLINE + 1];
    va_list ap;

    va_start(ap, fmt);

    vsnprintf(buf, MAXLINE, fmt, ap);
    snprintf(buf + strlen(buf), MAXLINE - strlen(buf), ": %s",
             strerror(err));
    strcat(buf, "\n");
    fputs(buf, stderr);

    va_end(ap);
}

void FileOperFunctions(char *pathname)
{
    FILE *fp = NULL;
    char ch;
    char str[255];
#if 0
    File functions *fopen * fclose
#endif
     fp = fopen("/tmp/notexist", "r");

#if 0
    I / O functions * stdin * stdout * stderr
#endif
#if 0
        Error functions * errno * perror * strerror
#endif
        if (fp == NULL) {
        printf("errno : %d, description : %s\n", errno, strerror(errno));
        perror("Open file notexist");
    } else {
        fclose(fp);
    }

#if 0
    Character functions *getchar * putchar * fputc
#endif
    if ((fp = fopen("/tmp/notexist", "w+")) == NULL) {
        printf("errno : %d, description : %s\n", errno, strerror(errno));
        perror("Open file notexist");
    }
#if 0
    while ((ch = getchar()) != EOF) {
        if (ch == '!') {
            break;
        }
        fputc(ch, fp);
    }
    fputc('\n', fp);
#endif
    fputs("I am here to test character operation functions!\n", fp);
    rewind(fp);

    while ((ch = fgetc(fp)) != EOF) {
        putchar(ch);
    }

#if 0
    File location functions *rewind * fseek * ftell
#endif
     fseek(fp, 5, SEEK_SET);
    fgets(str, 8, fp);
    printf("%s\n", str);
    printf("Current file pointer is %ld\n", ftell(fp));

    fclose(fp);

#if 0
    File operation functions *fread * fwrite
#endif
        typedef struct record {
        char name[10];
        int age;
    } record_t;

    if ((fp = fopen("/tmp/notexist", "w+")) == NULL) {
        printf("errno : %d, description : %s\n", errno, strerror(errno));
        perror("Open file notexist");
    }

    record_t array[2] = { {"Ken", 24}
    , {"Knuth", 28}
    };
    fwrite(array, sizeof(record_t), 2, fp);

    rewind(fp);
    record_t array_r[2];
    fread(array_r, sizeof(record_t), 2, fp);

    printf("Name1: %s\tAge1: %d\n", array_r[0].name, array_r[0].age);
    printf("Name2: %s\tAge2: %d\n", array_r[1].name, array_r[1].age);

    fclose(fp);

#if 0
    Formatted file record operation functions
        * printf
        * fprintf
        * sprintf * snprintf * vprintf * vfprintf * vsprintf * vsnprintf
#endif
#if 0
     Formatted file read operation functions * scanf * fscanf * sscanf
#endif
    if ((fp = fopen(pathname, "r")) == NULL) {
        err_sys("Line %d - Open file %s", __LINE__, pathname);
    } else {
        fclose(fp);
    }

#if 0
    flush the buffer
#endif
     printf("fflush test");
    fflush(stdout);
    putchar('\n');
}

/*  ===========================================================================
 *  Data type convert method
 */
void DataConvert()
{
#if 0
    Data convert methods *atoi * atof * strtol * strtod
#endif
     printf("atoi of 123ad is %d\n", atoi("123ad"));
    printf("atof of 0.14 is %f\n", atof("0x14eafe"));
}

/*  ===========================================================================
 *  Main
 */
int main(int argc, char *argv[])
{
    float number = -112;
    float sqrtnum = 121;
    int printLen = 0;
    int *randomNum;
    int i;
    char pathname[255];

    tPoint point1 = { 1, 2 };
    tPoint point2 = { 4, 6 };

    if (argc != 2) {
        fputs("Usage: ./Lesson <pathname>\n", stderr);
        _exit(0);
    } else {
        strncpy(pathname, argv[1], sizeof(pathname));
    }

    printLen = printf("Hello world!\n");
    printLen =
        printf
        ("character: %c\ninteger: %d\nfloating point: %f, printLen = %d\n",
         '}', 34, 3.14, printLen);
    printLen =
        printf("sin(pi/2)=%f\nln1=%f, printLen = %d\n", sin(pi / 2),
               log(1.0), printLen);

    printLen = printf("absolute of number is %f\n", fabs(number));
    printLen = printf("sqrt of number is %f\n", sqrt(sqrtnum));

    printLen =
        printf("Area of (1, 2) (4, 6) is %f\n",
               getArea(getRadius(point1, point2)));

    printLen = printf("Fibonacci of 10 is %d\n", Fibonacci(10));
    printLen = printf("FibonacciLoop of 10 is %d\n", FibonacciLoop(10));

    randomNum = printRandom(10);
    printf("Generateing 20 random number :");
    for (i = 0; i < N; i++) {
        printf(" %d", *(randomNum + i));
    }
    printf("\n");
    free(randomNum);

    GestureGame(1);

    Algorithm();

    StackSim();

    TypeConversion();

    BitOper();
    BitField();

    SizeAndType();

    Variates();
    printf("valA 2 is %d, valB 2 is %d\n", valA, valB);
    Variates();
    printf("valA 2 is %d, valB 2 is %d\n", valA, valB);

    ComplexDefine();

    DynamicApp();

    errorPrint();

    FormatInput();

    StringFunctions();

    FileOperFunctions(pathname);

    DataConvert();
    return 0;
}
