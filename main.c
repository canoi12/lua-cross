#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main(int argc, char** argv) {
    lua_State* L = luaL_newstate();
    fprintf(stdout, "working\n");
    luaL_dostring(L, "print('Hello World')");
    lua_pcall(L, 0, 0, 0);
    lua_close(L);
    return 0;
}
