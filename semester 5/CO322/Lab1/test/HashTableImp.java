
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Scanner;

/*********************************************
 * CO322: Data structures and algorithms
 * Implementation of the hashTable
 *********************************************/
class HashTableImp implements HashTable {

    /* Put your code here */
    public word [] list ;
    public static int buckets = 5;
    public static int count[] = new int[buckets];
    public static int total [] = new int[buckets];
    
    public static int hashFunNo = 0;
    
    final Object[][] table = new String[buckets+1][];


    public HashTableImp(int buckets) {
	// create a open hash table with given number of buckets
       list = new word[buckets];
    }
    // end HashTableImp 

    @Override
    public void insert(String key) {

        int x = HashFun(key,buckets,hashFunNo);

        word tmp = list[x];
        while(true){
            
            if(tmp == null){
                tmp = new word(key);
                list[x] = tmp;

                tmp = tmp.getNext();
                break;
            }else if(tmp.getNext() == null){
                word w = new word(key);
                tmp.setNext(w);
                break;
            }else{
                if(tmp.getKey().equals(key)){
                    tmp.incCount();
                    break;
                }
                tmp = tmp.getNext();
            }
           
        }
    }

    @Override
    public int search(String key) {

        int x = HashFun(key,buckets,hashFunNo);
        word tmp = list[x];

        while(tmp != null){
            
            if(tmp.getKey().equals(key)){
               return tmp.getCount();
            }
            tmp = tmp.getNext();
        }
        return 0;
    }
    
    public int HashFun(String s,int buckets,int hashFunNo){
        
        int key = 0;
        if(hashFunNo==1){
            key = s.length() % buckets;
        }else if(hashFunNo == 2){
            int sum=0;
            char[] chars = s.toCharArray();
            int i=0;
            for(;i<chars.length;i++){
                sum += chars[i];
            }
            key = sum/i % buckets;
        }
        
        return key;
    }
    
    
    public static String checkLetter(String in){
        int a = 0;
        char word [] = in.toCharArray();
        char tmp [] = new char [word.length + 1];
        
        for(int i=0;i<word.length;i++){
            if(Character.isLetter(word[i])){
                tmp[a] = word[i];
                a++;
            }
        }
        char out [] = new char [a];
        System.arraycopy(tmp, 0, out, 0, a);
        
        if(a==0){
            return null;
        }
        
        return String.valueOf(out);
    }
    
    public static String scanfun(String display){
        Scanner sc = new Scanner(System.in);
        System.out.print(display);
        String in;
        in = sc.nextLine();
        System.out.println("--------------------------------------");
        return in;
    }
    
    public void summary(HashTableImp map){
        int sumArray = 0, sum = 0,count = 0,m=0;
        String key=null;
        
        for(int i=0;i<buckets;i++){
            word w = list[i];
            while(w != null){
                count = w.getCount();
                key = w.getKey();
                
                sum += count;
                sumArray += count;
                m++;
                
                w = w.getNext();
            }
         
            HashTableImp.total[i] = sumArray;
            sumArray = 0;
            HashTableImp.count[i] = m;
            m=0;
        }

        table[0] = new String[] { "BUCKET NO", "SUM" ,"COUNT"};
        //table[0] = new String[] { "COUNT"};

        for(int i=0;i<buckets;i++){
            
            sumArray = HashTableImp.total[i];
            m = HashTableImp.count[i];
            
            table[i+1] = new String[] {  Integer.toString(i+1),  Integer.toString(sumArray) , Integer.toString(m)};
            //table[i+1] = new String[] {  Integer.toString(m)};
        }
        
        for (final Object[] row : table) {

            System.out.format("%15s%15s%15s\n", row);
            //System.out.format("%15s\n", row);
        }
        System.out.println("\nTotal words in file : " + sum);
        System.out.println("---------------------------------------------------------------------------------------------------");
    }

    public static void main(String [] args) throws FileNotFoundException, IOException{
		
		try{
			String FILENAME = "sample-text1.txt";
			HashTableImp.hashFunNo = 2;
        
			if(args.length>=2){
				FILENAME = args[0];
				int no = Integer.valueOf(args[1]);
				if(no<1 || no>2){
					System.out.println("Enter 1 or 2 for hash function no");
					return;
				}
				HashTableImp.hashFunNo = no;
			}
			
			String content = new String(Files.readAllBytes(Paths.get(FILENAME)));
			String [] words = content.split(" ");
			HashTableImp map = new HashTableImp(buckets);
			
			for (String word : words) {
				String s;
				s = checkLetter(word);
				if(s!=null){
					map.insert(s);
				}        
			}
			map.summary(map);        
			while(true){
				String searchWord = scanfun("Enter word  : ");
				int result = map.search(searchWord);    
				System.out.println(result);
			}
			
		}catch(IOException ex){
			System.out.println (ex.toString());
			System.out.println("Could not find file ");
		}
  
    }
}
