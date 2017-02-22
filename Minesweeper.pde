

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_COLS = 20;
private final static int NUM_ROWS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined


void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];

     for(int r = 0; r < NUM_ROWS; r++)
     {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);        
        }
     }
    bombs = new ArrayList <MSButton>();  
    setBombs();
}
public void setBombs()
{
    //your code
     while(bombs.size() <= 20)
     {
         int r = (int)(Math.random()*NUM_ROWS);
         int c = (int)(Math.random()*NUM_COLS);

         if(!bombs.contains(buttons[r][c]))
         {
            bombs.add(buttons[r][c]);
         }   
     }

}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();

}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
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
        //your code here
        if(keyPressed == true)
        {
            if(marked == true)
                marked = false;
            else if (marked == false)
                marked = true;
            if(marked == false)
                clicked = false;              
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        else if (countBombs(r,c) > 0)
            label = ""+countBombs(r,c);

        else
        {
            buttons[r-1][c].mousePressed();              
            buttons[r][c-1].mousePressed();
            buttons[r-1][c-1].mousePressed();
            buttons[r+1][c].mousePressed();
            buttons[r][c+1].mousePressed();
            buttons[r+1][c+1].mousePressed();
            buttons[r-1][c+1].mousePressed();
            buttons[r+1][c-1].mousePressed();           
        }

      
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
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
        //your code here
        if(r >= 0)
            return true;
        if(c >= 0)
            return true;
        else
        return false;
    }
    public int countBombs(int r, int c)
    {
        int numBombs = 0;
        //your code here
        if(isValid(r-1, c) == true && bombs.contains(buttons[r-1][c]))
            numBombs ++;
        if(isValid(r, c-1) == true && bombs.contains(buttons[r][c-1]))
            numBombs ++;
        if(isValid(r-1, c-1) == true && bombs.contains(buttons[r-1][c-1]))
            numBombs ++;
        if(isValid(r+1, c) == true && bombs.contains(buttons[r+1][c]))
            numBombs ++;
        if(isValid(r, c+1) == true && bombs.contains(buttons[r][c+1]))
            numBombs ++;
        if(isValid(r+1, c+1) == true && bombs.contains(buttons[r+1][c+1]))
            numBombs ++;
        if(isValid(r-1, c+1) == true && bombs.contains(buttons[r-1][c+1]))
            numBombs ++;
        if(isValid(r+1, c-1) == true && bombs.contains(buttons[r+1][c-1]))
            numBombs ++;
        return numBombs;   
    }
}
