#include <stdio.h>
//bcc -Md  -o hello.com hello.c

int main(){
    printf("%p\n",__get_cs());
    return 0;
}
