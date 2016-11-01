#ifndef MY_GLOBAL_MESSAGES_DEFINITIONS
#define MY_GLOBAL_MESSAGES_DEFINITIONS

#define QUEUE1 "/my_message_queue_1"
#define QUEUE2 "/my_message_queue_2"

// flags to control behavior of queue: blocking, non-blocking
//  use blocking queue -> flags = 0
#define MYQ_FLAGS    0

// max. number of messages in queue
//  must be lower/equal than value in /proc/sys/fs/mqueue/msg_max
#define MYQ_MESGS   10

// max. size of message
//  must be lower/equal than value in /proc/sys/fs/mqueue/msgsize_max
#define MYQ_MSGSZ   64

#endif
