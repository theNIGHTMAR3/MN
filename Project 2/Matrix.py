from math import sin

class Matrix:
    def __init__(self,index,size=0):
        #distribution of index digits
        self.index_digits = [int(a) for a in str(index)]
        
        #N
        if size==0:
            self.N=int(9*100+self.index_digits[4]*10+self.index_digits[5])
        else:
            self.N=int(size)

    #generates matrix with given input
    def generate_matrix(self,a1,a2,a3):
        #empty array
        A=[]

        for i in range(self.N):
            #for each row
            row=[]
            for j in range(self.N):
                #main diagonal
                if(i==j):
                    row.append(a1)
                #side diagonals
                elif i-1<=j and j<=i+1:
                    row.append(a2)
                #extreme diagonals
                elif i-2<=j and j<=i+2:
                    row.append(a3)
                #not any diagonal, fill with 0
                else:
                    row.append(int(0))
            A.append(row)
        return A

#task A
    def generate_matrix_task_A(self):
        #a1=4th index digit
        #a2=-1
        #a3=-1
        return self.generate_matrix(self.index_digits[3]+5,-1,-1)


    def generate_vector_b(self):
        vector_b=[]
        #vector has size N
        for i in range(self.N):
            vector_b.append(sin(i*(self.index_digits[2]+1)))
        return vector_b

    def generate_matrix_task_C(self):
        #a1=3
        #a2=-1
        #a3=-1
        return self.generate_matrix(3,-1,-1)





