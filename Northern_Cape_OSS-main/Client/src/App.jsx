import { BrowserRouter as Router } from 'react-router-dom';
import './App.css';
import Nav from './layout/nav.jsx';
import AppRoutes from './routes/AppRoutes.jsx';

function App() {
  return (
    <Router>
      <Nav />
      <AppRoutes />
    </Router>
  );
}

export default App
