"""Implement quick sort in Python.
Input a list.
Output a sorted list."""

def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    else:
        pi = len(arr) - 1
        pivot = arr[pi]
        i = 0
        
        while i < pi:
            while arr[i] > pivot:
                item = arr[i]
                arr[i] = arr[pi-1]
                arr[pi-1] = pivot
                arr[pi] = item
                pi -= 1
            i += 1
        
        arr[0:pi] = quick_sort(arr[0:pi])
        arr[pi:len(arr)] = quick_sort(arr[pi:len(arr)])
        
        return arr

# Driver Code 
if __name__ == '__main__' : 
      
    arr = [21, 4, 1, 3, 9, 20, 25, 6, 21, 14]
    n = len(arr)
    
    print("Before:")
    for i in range(n): 
        print(arr[i], end=" ") 
    
    print('\n')

    # Calling quickSort function 
    quick_sort(arr)
    
    print("After:")
    for i in range(n): 
        print(arr[i], end=" ") 

    print('\n')
