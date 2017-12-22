namespace Quantum.q_sharp_bell_state
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;

    operation Set (desired: Result, q1: Qubit) : ()
    {
        body
        {
			let current = M(q1);

            if (desired != current)
            {
				// X gate flips the state of Qubit
                X(q1);
            }
            
        }
    }

	operation BellTest (count : Int, initial: Result) : (Int,Int,Int)
    {
        body
        {
            mutable numOnes = 0;
			mutable agree = 0;
            using (qubits = Qubit[2])
            {
                for (test in 1..count)
                {
                    Set (initial, qubits[0]);
					Set (Zero, qubits[1]);
					
					// Try to flip it
					// X(qubits[0]);

					// Try to get Quantum Result by setting Hadamard gate
					H(qubits[0]);

					// Output, may vary every time we build and run
					// This is known as superposition.
					// Init:Zero 0s=484  1s=516
					// Init:One  0s=522  1s=478
                    
					// For entanglement
					CNOT(qubits[0],qubits[1]);

					let res = M (qubits[0]);

					if (M (qubits[1]) == res) {
						set agree = agree + 1;
					}

                    // Count the number of ones we saw:
                    if (res == One)
                    {
                        set numOnes = numOnes + 1;
                    }
                }
                Set(Zero, qubits[0]);
				Set(Zero, qubits[1]);
            }
            // Return number of times we saw a |0> and number of times we saw a |1>
            return (count-numOnes, numOnes, agree);
        }
    }
}
