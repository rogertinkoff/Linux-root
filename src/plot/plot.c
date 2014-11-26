#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int sWindowWidth = 188;
static int sWindowHeight = 53;

#define HALF_WIN_WIDTH (sWindowWidth >> 1)
#define HALF_WIN_HEIGHT (sWindowHeight >> 1)

static void ClearFrameBuf(char *frameBuf)
{
    if (frameBuf)
    {
        memset(frameBuf, 0, sWindowWidth*sWindowHeight*sizeof(char));
    }
}

static void DrawAxes(char *frameBuf)
{
    if (frameBuf)
    {
        int i = 0;

        for (i = 0; i < sWindowWidth; i++)
        {
            frameBuf[(HALF_WIN_HEIGHT)*sWindowWidth + i] = '-';
        }

        for (i = 0; i < sWindowHeight; i++)
        {
            frameBuf[sWindowWidth*i + HALF_WIN_WIDTH] = '|';
        }
    }
}

static void Render(char *frameBuf)
{
    if (frameBuf)
    {
        int i = 0, j = 0;

        for (j = 0; j < sWindowHeight; j++)
        {
            for (i = 0; i < sWindowWidth; i++)
            {
                char currentChar = frameBuf[j*sWindowWidth + i];

                if (currentChar != 0)
                {
                    printf("%c", currentChar);
                }
                else
                {
                    printf(" ");
                }
            }

            printf("\n");
        }
    }
}

static void DrawPixel(char *frameBuf, int x, int y)
{
    if (frameBuf &&
        (x >= -HALF_WIN_WIDTH) &&
        (x <= HALF_WIN_WIDTH) &&
        (y >= -HALF_WIN_HEIGHT) &
        (y <= HALF_WIN_HEIGHT))
    {
        int i = x + HALF_WIN_WIDTH;
        int j = -y + HALF_WIN_HEIGHT;

        frameBuf[i +sWindowWidth*j] = 'x';
    }
}

static void DrawLine(char *frameBuf, int mnum, int mdenom, int b)
{
    if (frameBuf && (mdenom != 0))
    {
        int x = 0;

        for (x = -HALF_WIN_WIDTH; x < HALF_WIN_WIDTH; x++)
        {
            int y = x*mnum/mdenom;

            DrawPixel(frameBuf, x, y);
        }
    }
}

static void DrawCircle(char *frameBuf, int centerx, int centery, unsigned int r, unsigned int filled)
{
    if (frameBuf && (r != 0))
    {
        int x = 0, y = 0;

        for (y = -HALF_WIN_HEIGHT; y < HALF_WIN_HEIGHT; y++)
        {
            for (x = -HALF_WIN_WIDTH; x < HALF_WIN_WIDTH; x++)
            {
                int sumsquared = x*x + y*y;
                int radsquared = r*r;

                if ((sumsquared == radsquared) ||
                    (filled && (sumsquared < radsquared)))
                {
                    DrawPixel(frameBuf, centerx + x, centery + y);
                }
            }
        }
    }
}

int main(int argc, char **argv)
{
    int i = 0;
    char *frameBuf = NULL;

    for (i = 1; i < argc; i++)
    {
        if (strcmp(argv[i], "--windowwidth") == 0)
        {
            sWindowWidth = atoi(argv[++i]);
        }
        else if (strcmp(argv[i], "--windowheight") == 0)
        {
            sWindowHeight = atoi(argv[++i]);
        }
    }

    printf("window width:  %d\n", sWindowWidth);
    printf("window height: %d\n", sWindowHeight);

    frameBuf = (char *)malloc(sWindowWidth*sWindowHeight);
    if (frameBuf == NULL)
    {
        fprintf(stderr, "malloc() of frameBuf failed\n");
        return -1;
    }

    ClearFrameBuf(frameBuf);

    printf("\n");

    DrawAxes(frameBuf);

//    DrawLine(frameBuf, 1, 4, 0);

    DrawCircle(frameBuf, 0, 0, 5, 1);

    Render(frameBuf);
    
	return 0;
}
