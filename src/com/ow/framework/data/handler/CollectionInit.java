package com.ow.framework.data.handler;



import java.util.ArrayList;

public class CollectionInit {  

    private ArrayList<IHandlerCriteria> init = new ArrayList<IHandlerCriteria>();

    public CollectionInit() {
    }

    public void addInit(IHandlerCriteria handlerCriteria)
    {
        init.add(handlerCriteria);
    }

    public ArrayList<IHandlerCriteria> getInit()
    {
        return init;
    }


    public void doInit()
    {
        for (int i=0; i <init.size(); i++)
        {

            if (init.get(i) == null)
                continue;
            IHandlerCriteria handlerCriteria = (IHandlerCriteria)init.get(i);
            handlerCriteria.appInit();
        }
    }
}
