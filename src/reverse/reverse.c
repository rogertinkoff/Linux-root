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

static void
ReverseList(Node **head)
{
	Node *current = NULL;
	Node *prev = NULL;

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

	if ((*head)->next == NULL)
	{
		return;
	}

	current = *head;
	prev = NULL;

	while (current)
	{
		Node *next = current->next;
		current->next = prev;
		prev = current;
		current = next;
	}

	*head = prev;
}

int main(int argc, char **argv)
{
	printf("Test 1\n");

	Node *head0 = NULL;
	Node *node0_0 = CreateNode(0);

	head0 = AttachNodeAtHead(&head0, node0_0);
	DumpList("Initial", head0);
	ReverseList(&head0);
	DumpList("Reversed", head0);
	EmptyList(&head0);

	printf("Test 2\n");

	Node *head1 = NULL;
	Node *node1_0 = CreateNode(0);
	Node *node1_1 = CreateNode(1);

	head1 = AttachNodeAtHead(&head1, node1_1);
	head1 = AttachNodeAtHead(&head1, node1_0);
	DumpList("Initial", head1);
	ReverseList(&head1);
	DumpList("Reversed", head1);
	EmptyList(&head1);

	printf("Test 2\n");

	Node *head2 = NULL;
	Node *node2_0 = CreateNode(0);
	Node *node2_1 = CreateNode(1);
	Node *node2_2 = CreateNode(2);
	Node *node2_3 = CreateNode(3);
	Node *node2_4 = CreateNode(4);

	head2 = AttachNodeAtHead(&head2, node2_4);
	head2 = AttachNodeAtHead(&head2, node2_3);
	head2 = AttachNodeAtHead(&head2, node2_2);
	head2 = AttachNodeAtHead(&head2, node2_1);
	head2 = AttachNodeAtHead(&head2, node2_0);
	DumpList("Initial", head2);
	ReverseList(&head2);
	DumpList("Reversed", head2);
	EmptyList(&head2);

	return 0;
}