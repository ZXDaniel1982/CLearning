/*******************************************************************************
 *    (c) Copyright 2017 Aviat Networks, all rights reserved
 ******************************************************************************/

/*******************************************************************************
 * @{
 * @file    ks_main.c
 * @brief   This file contains main functions for key storage feature
 ******************************************************************************/

/******************************************************************************
 *    Include files
 *****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <getopt.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>
#include <signal.h>

/******************************************************************************
 *    Definitions / macros
 *****************************************************************************/
#define DAEMON_NAME "RamSdSync(RSS)"

#define KS_ONE_SECOND_TIME_INTERVAL 1     // 1 second
#define POLL_TIMEOUT              500   // 500 milisecond

/******************************************************************************
 *    Variables
 *****************************************************************************/
typedef struct
{
    bool daemonMode;
} opt_t;

enum {
    KS_TIMER_WATCHDOG = 0,
    KS_INOTIFY_FD,
    MAX_FD
};

/* Program command line usage */
static char *usage = "Usage : %s [-d] [-h] \n"
                     "Ram Sd Sync daemon\n\n"
                     "  -d, --daemon       run in daemon mode\n"
                     "  -h, --help         display this help and exit\n"
                     "\n";

struct option longopts[] =
{
  { "daemon",      no_argument,       NULL, 'd'},
  { "help",        no_argument,       NULL, 'h'},
  { 0 }
};

static volatile sig_atomic_t running = 1;
/******************************************************************************
 *    Local functions
 *****************************************************************************/

/*******************************************************************************
 *  @brief      This function process the input args.
 *
 *  @param[in]  argc
 *  @param[in]  argv
 *  @param[in]  options
 ******************************************************************************/
static void rss_parseArgs(int argc, char **argv, opt_t *options)
{
    char *progName;
    char *p;
    int opt;

    /* Preserve name of myself. */
    progName = ((p = strrchr(argv[0], '/')) ? ++p : argv[0]);

    /* set default option values */
    memset(options, 0, sizeof(opt_t));

    while ((opt = getopt_long(argc, argv, "?hd:", longopts, 0)) != EOF)
    {
        switch (opt)
        {
            case 'd':
                options->daemonMode = true;
                break;
            case '?':
            case 'h':
                fprintf(stdout, usage, progName);
                exit(EXIT_SUCCESS);
                break;
            default:
                fprintf(stderr, usage, progName);
                exit(EXIT_FAILURE);
                break;
        }
    }
}

/*******************************************************************************
 *  @brief Parse command line arguments
 *
 *  @param[in]    signum
 *  @param[in]    siginfo
 *  @param[in]    arg
 *  @return       none
 ******************************************************************************/

static void savefile(void)
{
    FILE *fd = NULL;
	static int cnt = 0;

	fd = fopen("/tmp/autofile", "a+");
	if (fd == NULL) {
        return;
	}

	fprintf(fd, "save to file count %d\n", cnt++);
	fclose(fd);

	printf("saved auto\n");
}

/*******************************************************************************
 *  @brief      This is the main function for Key Storage feature
 *
 *  @param[in]  argc
 *  @param[in]  argv
 ******************************************************************************/
int main(int argc, char **argv)
{
    opt_t argOpt;

    rss_parseArgs(argc, argv, &argOpt);

    if(daemon(1, 1) < 0)
    {
        perror("error daemon.../n");
        exit(1);
    }


    while (running) {
            sleep(1);
            savefile();
    }

    return 0;
}

