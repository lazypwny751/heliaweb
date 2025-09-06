import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"
// import { Card, CardContent } from "@/components/ui/card";

import { Terminal } from "lucide-react";
import "./assets/css/index.css";

import logo from "./assets/svg/logo.svg";

export function App() {
  return (
    <div className="container mx-auto p-8 text-center relative z-10">
      <div className="flex justify-center items-center gap-8 mb-8">
        <img
          src={logo}
          alt="Bun Logo"
          className="h-36 p-6 transition-all duration-300 hover:drop-shadow-[0_0_2em_#646cffaa] scale-120"
        />

        <Alert variant="default" className="max-w-sm">
          <Terminal />
          <AlertTitle>Heads up!</AlertTitle>
          <AlertDescription>
            You can add components and dependencies to your app using the cli.
          </AlertDescription>
        </Alert>
      </div>
    </div>
  );
}

export default App;
