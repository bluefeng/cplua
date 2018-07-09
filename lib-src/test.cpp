

extern "C" {
    #include "lua.h"
    #include "lualib.h"
    #include "lauxlib.h"
    int luaopen_test(lua_State *L);
}

#include <stdio.h>
static int averageFunc(lua_State *L)
{
    int n = lua_gettop(L);
    double sum = 0;
    int i;
    
    /* 循环求参数之和 */
    for (i = 1; i <= n; i++)
        sum += lua_tonumber(L, i);
    
    lua_pushnumber(L, sum / n);     //压入平均值
    lua_pushnumber(L, sum);         //压入和
    
    return 2;                       //返回两个结果
}

static int sayHelloFunc(lua_State* L)
{
    printf("hello world!\n");
    return 0;
}

static const struct luaL_Reg myLib[] =
{
    {"average", averageFunc},
    {"sayHello", sayHelloFunc},
    {NULL, NULL}       //数组中最后一对必须是{NULL, NULL}，用来表示结束
};

int luaopen_test(lua_State *L)
{
    lua_newtable(L);
    luaL_setfuncs(L, myLib, 0);
    return 1;
}

