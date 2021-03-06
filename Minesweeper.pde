


import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            buttons[r][c] = new MSButton(r,c);
    
    for(int i = 0; i < 15; i++){
        setBombs();
    }
}
public void setBombs()
{
    int ranRow = (int)(Math.random()*NUM_ROWS);
    int ranCol = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[ranRow][ranCol])){
            bombs.add(buttons[ranRow][ranCol]);
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
    for(int r = 0; r < NUM_ROWS; r++)
       for(int c = 0; c < NUM_COLS; c++)   
            if(!buttons[r][c].isMarked() && !buttons[r][c].isClicked())
                return false;
    return true;
}
public void displayLosingMessage()
{
  for (int r=0; r<NUM_ROWS; r++){
    for (int c=0; c<NUM_COLS; c++){
      if (bombs.contains(buttons[r][c])&& !buttons[r][c].isClicked()){
        buttons[r][c].marked=false;
        buttons[r][c].clicked=true;
      }
    }
  }
    
}
public void displayWinningMessage()
{
  for(int i = bombs.size()-1; i >= 0; i--){
    bombs.remove(i);
  }    
  for (int r=0; r<NUM_ROWS; r++){
    for (int c=0; c<NUM_COLS; c++){ 
        buttons[r][c].marked=false;
        buttons[r][c].clicked=true;
        buttons[r][c].setLabel("");
    }
  }
     buttons[7][7].marked = true;
     buttons[7][12].marked = true;
     buttons[11][6].marked = true;
     buttons[11][13].marked = true;
     buttons[12][7].marked = true;
     buttons[12][8].marked = true;
     buttons[12][9].marked = true;
     buttons[12][10].marked = true;
     buttons[12][11].marked = true;
     buttons[12][12].marked = true;


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
        if(keyPressed && keyCode == 16){
            marked = !marked;
            if(!marked) clicked = false;
        } else if(bombs.contains(this)){
            displayLosingMessage();
        } else if(countBombs(r,c) > 0){
           label = "" + countBombs(r,c);
        } else {
            if(isValid(r,c+1) && !buttons[r][c+1].clicked) 
                buttons[r][c+1].mousePressed();
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].clicked) 
                buttons[r+1][c+1].mousePressed();
            if(isValid(r-1,c+1)  && !buttons[r-1][c+1].clicked) 
                buttons[r-1][c+1].mousePressed();
            if(isValid(r,c-1) && !buttons[r][c-1].clicked) 
                buttons[r][c-1].mousePressed();
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].clicked) 
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].clicked) 
                buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c) && !buttons[r+1][c].clicked) 
                buttons[r+1][c].mousePressed();
            if(isValid(r-1,c) && !buttons[r-1][c].clicked) 
                buttons[r-1][c].mousePressed();
        }

    }

    public void draw () 
    {    
        if(marked)
            fill(0,255,0);
        else if(clicked && bombs.contains(this)) 
            fill(255,0,0);
        /*else if(clicked && !bombs.contains(this))
            marked = false;*/
        else if(clicked)
            fill(255);
        else 
            fill( 100 );

        rect(x, y, width, height,2);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS){
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1])) numBombs++;
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1])) numBombs++;
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1])) numBombs++;
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1])) numBombs++;
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1])) numBombs++;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1])) numBombs++;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col])) numBombs++;
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col])) numBombs++;
        return numBombs;
    }

}


