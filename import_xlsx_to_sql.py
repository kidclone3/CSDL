import pandas as pd
from pandas.core.indexing import _iLocIndexer
df = pd.read_excel('congviec.xlsx')

# Should save the output to some external file.

print('INSERT INTO CONGVIEC(MADA, STT, TEN_CONG_VIEC) VALUES ', end = ' ')
for i in range(len(df)):
    print('(', end='')    
    for j in range(len(df.iloc[i])):
        if (j != len(df.iloc[i])-1):
            ed = ', '
        else:
            ed = ' '
        print(f'\'{df.iloc[i, j]}\'', end = ed)
    print(end = '),')
# print(df.iloc[0, 0])