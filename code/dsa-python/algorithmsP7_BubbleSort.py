"""Bubble Sort is the simplest sorting algorithm
that works by repeatedly swapping the adjacent 
elements if they are in wrong order."""

def bubble_sort(a):
    arr_length = len(a)
    for _ in range(arr_length-1):
        i, j  = 0, 1
        for _ in range(arr_length-1):
            if a[i] > a[j]:
                a[i], a[j] = a[j], a[i]
            i += 1
            j += 1
            
# Test cases
arr = [64, 34, 25, 12, 22, 11, 90]

bubble_sort(arr)

print("Sorted array is:")
for i in range(len(arr)):
    print("%d" %arr[i]), 
