<%

                java.util.Runtime runtimeEnv = java.util.Runtime.getRuntime();

                out.println("Total memory in JVM : " + runtimeEnv.totalMemory());
                out.println("Free memory : " + runtimeEnv.freeMemory());


                out.println("Free memory after Objects creation: " + runtimeEnv.freeMemory());

                //Call GC
                System.gc();

        out.println("Free memory after GC is run: "+ runtimeEnv.freeMemory() );
        out.println("Total memory in JVM : " + runtimeEnv.totalMemory());
               out.println("Free memory-v : " + runtimeEnv.freeMemory());

%>