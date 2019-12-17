package edu.sjsu.fwjs;

import java.util.ArrayList;

public class Interpreter {

    public static void main(String[] args) throws Exception {
        Expression prog = new BinOpExpr(Op.ADD,
                new ValueExpr(new IntVal(3)),
                new ValueExpr(new IntVal(4)));
        System.out.println("'3 + 4;' evaluates to " + prog.evaluate(new Environment()));
        
        Expression test = new BinOpExpr(Op.GT,
                new ValueExpr(new IntVal(3)),
                new ValueExpr(new IntVal(4)));
        System.out.println("'3 > 4;' evaluates to " + test.evaluate(new Environment()));

        
        Environment env = new Environment();
        env.updateVar("x", new IntVal(10));
        Expression whi = new WhileExpr(new BinOpExpr(Op.GT,
                new VarExpr("x"),
                new ValueExpr(new IntVal(0))),
            new AssignExpr("x",
                    new BinOpExpr(Op.SUBTRACT,
                            new VarExpr("x"),
                            new ValueExpr(new IntVal(1)))));
        System.out.println(whi.evaluate(new Environment())); 
        
        VarDeclExpr newVar = new VarDeclExpr("x", new ValueExpr(new IntVal(112358)));
        FunctionDeclExpr f = new FunctionDeclExpr(new ArrayList<String>(),
                new SeqExpr(new AssignExpr("x", new ValueExpr(new IntVal(42))),
                        new VarExpr("x")));
        SeqExpr seq = new SeqExpr(new SeqExpr(newVar,
                new FunctionAppExpr(f, new ArrayList<Expression>())),
                new VarExpr("x"));
       // Value v = seq.evaluate(new Environment());
       // System.out.println(seq.evaluate(new Environment())); 
    }
}
