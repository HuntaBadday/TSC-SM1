; Quicksort sorting routine
; HuntaBadday

;;void quicksort(int* arr, int start, int end){
;;	if (start >= end){
;;		return;
;;	}
;;	int pivotIndex = start;
;;	int pivotValue = arr[end];
;;	for(int i=start;i<end;i++){
;;		if(arr[i] < pivotValue){
;;			swap(arr, i, pivotIndex);
;;			pivotIndex++;
;;		}
;;	}
;;	swap(arr, pivotIndex, end);
;;	int index = pivotIndex;
;;	quicksort(arr, start, index-1);
;;	quicksort(arr, index+1, end);
;;	return;
;;}

; r1 - Array vector
; r2 - Start
; r3 - End
quicksort:
    ; if (start >= end){
    cmp r2, r3
    bcs .return
    mov r3, r3
    bmi .return
    
    mov r4, r2  ; int pivotIndex = start;
    mov r5, [r1+r3] ; int pivotValue = arr[end];
    
    ; for(int i=start;i<end;i++){
    mov r6, r2  ; int i = start;
.forloop:
    mov r7, [r1+r6] ; arr[i]
    cmp r7, r5  ; if (arr[i] < pivotValue){
    bcs .skipSwap
    
    ; swap(arr, i, pivotIndex);
    mov r8, [r1+r4] ; arr[pivotIndex]
    mov [r1+r6], r8
    mov [r1+r4], r7
    
    add r4, 1   ; pivotIndex++;
    
.skipSwap:
    add r6, 1   ; i++;
    cmp r6, r3  ; i < end
    bcc .forloop
    
    ; swap(arr, pivotIndex, end);
    mov r6, [r1+r4] ; arr[pivotIndex]
    mov r7, [r1+r3] ; arr[end]
    mov [r1+r4], r7
    mov [r1+r3], r6
    
    ; int index = pivotIndex;
    ; mov r4, r4    ; Just to show that r4 is reused for the index variable
                    ; virtually
    
    ; quicksort(arr, start, index-1);
    push r3
    push r4
    mov r3, r4
    sub r3, 1
    jsr quicksort
    pop r4
    pop r3
    
    ; quicksort(arr, index+1, end);
    push r2
    mov r2, r4
    add r2, 1
    jsr quicksort
    pop r2
.return:
    rts