#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <syslog.h>
#include <string.h>

int main(void) 
{
	/* Our process ID and Session ID */
	pid_t pid, sid;
	/* Fork off the parent process */
	pid = fork();
        if (pid < 0) {
                exit(EXIT_FAILURE);
        }
        /* If we got a good PID, then
           we can exit the parent process. */
        if (pid > 0) 
	{

		FILE* pfile;
		pfile = fopen("mainlog.txt", "w");
		if(pfile != NULL)
		{
			fprintf(pfile, "Proces Completed\n");
			fclose(pfile);
		}

        exit(EXIT_SUCCESS);
	}
	
	/* Change the file mode mask */
	umask(0);
        
	/* Open any logs here */
	FILE * logfile;
	logfile = fopen("phpdaemonlog.txt", "w");
	if(logfile != NULL)
	{
		fclose(logfile);
	}
        
	/* Create a new SID for the child process */
	sid = setsid();
	if (sid < 0) 
	{
		/* Log the failure */

		FILE * pfile;
		pfile = fopen("phpdaemonlog.txt", "a+");
		if(pfile != NULL)
		{
			fprintf(pfile, "sid < 0\n");
			fclose(pfile);
		}

		exit(EXIT_FAILURE);
	}
	//type or select a site
	/* Change the current working directory */
	/*
	if ((chdir("/")) < 0) {

		FILE * pfile;
		pfile = fopen("phpdaemonlog.txt", "a+");
		if(pfile != NULL)
		{
			fputs("changing dir failed\n", pfile);
			fclose(pfile);
		}

		exit(EXIT_FAILURE);
	}
	*/

	/* Close out the standard file descriptors */
	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);

	/* Daemon-specific initialization goes here */

	/* The Big Loop */
	while (1) 
	{

		FILE* pfile;
		pfile = fopen("mainlog.txt", "w");
		/* Do some task here ... */
		pid_t pID = fork();
		if(pID < 0)
		{
			printf("error forking\n");
			exit(1);
		}
		else if(pID == 0)//child process
		{
			pfile = fopen("mainlog.txt", "a+");
			fprintf(pfile,"child proccess started\n");
			execl("/usr/bin/php5", "php5", "-f", "mainscript.php", NULL);
			//execl("/bin/sh", "sh", "-c", "php -f /home/goran/LinuxDaemon/mainscript.php", NULL);
			fclose(pfile);
			//system("php -f /home/goran/LinuxDaemon/mainscript.php");
			//execl("/bin/sh", "-c", "php5", "-f", "mainscript.php", (const char *)0);
		}
		else//parent process
		{
			//fprintf(pfile,"parent proccess started\n");
			wait();
			kill(pID);
			//fprintf(pfile,"child terminated\n");
			fclose(pfile);
			//exit(EXIT_SUCCESS);
			//system("php -f mainscript.php");
			sleep(86400); /* wait 24 hours = 86400 */
		}
	}
	exit(EXIT_SUCCESS);
}

