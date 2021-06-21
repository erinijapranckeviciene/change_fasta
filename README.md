# change_fasta

Sripts to change substrings in fasta. 

 - Step 1 : for a given subset of SNVs extract fasta from the reference flanking by 500bp into the seq.tab file
 - Step 2 : for a given list of SNVs around the original SNV modify fasta according to the given change

Output of the Step 2 scipt in output-change-fasta.txt

Call scripts: 
  - bash step1-fasta-from-ref.sh
  - bash step2-change-fasta.sh
 
# Output of the Step 2

In Step 2 the original fasta sequences and changed sequences are printed to the standard output. The figure shows the original and changed sequences in red.

Figure 1. Output of the step2-change-fasta.sh
<img src="https://github.com/erinijapranckeviciene/change_fasta/raw/main/change-fasta-output.PNG">


