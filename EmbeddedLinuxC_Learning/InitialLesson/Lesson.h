#ifndef LESSON
#define LESSON

#define PushSim(a,b,c)     do {             \
            (c[b]) = a;                     \
            b++;                            \
        }while(0);

#define PopSim(a, b)       do {             \
            if(a > 0) {                     \
                a--;                        \
                printf("%c\n", b[a]);       \
            }                               \
        }while(0);
#endif