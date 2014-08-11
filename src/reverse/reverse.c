#include <stdio.h>
#include <stdlib.h>

typedef struct Node Node;

struct Node
{
	int value;
	Node *next;
};

static Node *
CreateNode(int value)
{
	Node *n = (Node *)malloc(sizeof(Node));

	if (n == NULL)
	{
		fprintf(stderr, "%s n is NULL", __FUNCTION__);
		return NULL;
	}

	n->value = value;

	return n;
}

static void
DestroyNode(Node **n)
{
	if (n == NULL)
	{
		fprintf(stderr, "%s n is NULL", __FUNCTION__);
		return;
	}

	if (*n)
	{
		free(*n);
		*n = NULL;
	}
}

static Node * 
AttachNodeAtHead(Node **head, Node *n)
{
	if (head == NULL)
	{
		fprintf(stderr, "%s head is NULL", __FUNCTION__);
		return NULL;
	}

	if (n == NULL)
	{
		fprintf(stderr, "%s n is NULL", __FUNCTION__);
		return NULL;
	}

	if (*head == NULL)
	{
		*head = n;
		n->next = NULL;
		return;
	}

	n->next = *head;
	*head = n;

	return n;
}

static Node *
DetachHeadNode(Node **head)
{
	Node *n = NULL;

	if (head == NULL)
	{
		fprintf(stderr, "%s head is NULL", __FUNCTION__);
		return NULL;
	}

	if (*head == NULL)
	{
		fprintf(stderr, "%s *head is NULL", __FUNCTION__);
		return NULL;
	}

	if ((*head)->next = NULL)
	{
		return NULL;
	}

	n = (*head)->next;

	return n;
}

static void
DumpList(char *tag, Node *head)
{
	Node *current = head;

	printf("[%s]: ", tag);

	while (current)
	{
		if (current->next)
		{
			printf("(%d) -> ", current->value);
		}
		else
		{
			printf("(%d) -> NULL\n", current->value);
		}

		current = current->next;
	}
}

static void EmptyList(Node **head)
{
	Node *current = NULL;

	if (head == NULL)
	{
		fprintf(stderr, "%s head is NULL", __FUNCTION__);
		return;
	}

	if (*head == NULL)
	{
		fprintf(stderr, "%s *head is NULL", __FUNCTION__);
		return;
	}

	current = *head;
	while (current)
	{
		Node *h = DetachHeadNode(&current);
		DestroyNode(&current);
		current = h;
	}
}

int main(int argc, char **argv)
{
	Node *head0 = NULL;
	Node *node0_0 = CreateNode(0);
	Node *node0_1 = CreateNode(1);

	head0 = AttachNodeAtHead(&head0, node0_1);
	head0 = AttachNodeAtHead(&head0, node0_0);
	DumpList("Initial", head0);

	EmptyList(&head0);

	return 0;
}