
import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private int NUM_ROWS = 20;
private int NUM_COLS = 20;
private int num_bombs = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> ();; //ArrayList of just the minesweeper buttons that are mined
private boolean on = true;

void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton [NUM_ROWS] [NUM_COLS];
    for(int i = 0; i < NUM_ROWS; i++)
        for(int n = 0; n < NUM_COLS; n++)
            buttons[i][n] = new MSButton(i,n);
    
    setBombs();
}

public void setBombs()
{
    for(int i = 0; i < num_bombs; i++){
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[row][col])){
            bombs.add(buttons[row][col]);
            //System.out.println(row + " , " + col);
        }else{
            i = i-1;     
        }
    }
}

public void draw ()
{
    //background(200);
    //System.out.println(mouseY);
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for (int i = 0; i < bombs.size(); i++)
    {
        if (!bombs.get(i).isMarked())
            return false;
    }
    return true;
}
public void displayLosingMessage()
{
    stroke(255,0,0);
    textAlign(CENTER, CENTER);
    text("You Lose! \n Please, for the love of cheese, don't apply to be \n military minesweeper", 200 ,440);
    stroke(0);
}
public void displayWinningMessage()
{
    //your code here
    stroke(255,0,0);
    textAlign(CENTER, CENTER);
    text("You Win!", 450,425);
    stroke(0);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;//Jimmy was here
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
            marked = !marked;
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c) > 0)
            setLabel(""+ countBombs(r,c));
        else{ // program only opened to the right
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked()){
                buttons[r-1][c+1].mousePressed();
            }
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked()){
                buttons[r+1][c+1].mousePressed();
            }
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked()){
                buttons[r-1][c].mousePressed();
            }
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
                buttons[r+1][c].mousePressed();
            }
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked()){
                buttons[r-1][c-1].mousePressed();
            }
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked()){
                buttons[r+1][c-1].mousePressed();   
            }
        }         
    }

    public void draw () 
    {    
        if (marked)
            fill(0,255,0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        return (r>=0 && r < NUM_ROWS) && (c >= 0 && c < NUM_COLS);
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        //System.out.println(numBombs);
        return numBombs;
        }
}



