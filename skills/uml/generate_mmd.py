import sys, os

def generate_mmd(usecase_name, controller, path):
    out_dir = f"./docs/uml/{usecase_name}"
    os.makedirs(out_dir, exist_ok=True)
    
    # Class Diagram: Controller -> Service -> Mapper
    with open(f"{out_dir}/class.mmd", "w") as f:
        f.write(f"classDiagram\n    class {controller}Controller\n    class {controller}Service\n    class {controller}Mapper\n    {controller}Controller --> {controller}Service\n    {controller}Service --> {controller}Mapper")
    
    # Sequence Diagram: Request -> Controller -> Service -> Mapper
    with open(f"{out_dir}/sequence.mmd", "w") as f:
        f.write(f"sequenceDiagram\n    participant U as User\n    participant C as {controller}Controller\n    participant S as {controller}Service\n    participant M as {controller}Mapper\n    U->>C: {path}\n    C->>S: call\n    S->>M: query\n    M-->>S: data\n    S-->>C: result\n    C-->>U: response")

if __name__ == "__main__":
    generate_mmd(sys.argv[1], sys.argv[2], sys.argv[3])
