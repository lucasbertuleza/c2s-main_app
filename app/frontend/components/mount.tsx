/* eslint-disable no-console */
import React from 'react';
import ReactDOM from 'react-dom/client';

type Components = Record<string, React.ElementType>;

function logComponentNotFound(name: string, components: Components): void {
  if (import.meta.env.DEV)
    console.warn('WARNING: No component found for: ', name, Object.keys(components));
}

export default function mount(components: Components): void {
  document.addEventListener('DOMContentLoaded', () => {
    const mountPoints = document.querySelectorAll('[data-react-component]');

    mountPoints.forEach((mountPoint) => {
      const { dataset } = mountPoint as HTMLElement;
      const componentName = dataset['reactComponent'] ?? '';
      const Component = components[componentName];

      if (!Component) {
        logComponentNotFound(componentName, components);
        return;
      }

      const props = JSON.parse(dataset['props'] ?? '{}') as object;
      const root = ReactDOM.createRoot(mountPoint);

      // eslint-disable-next-line react/jsx-props-no-spreading
      root.render(<Component {...props} />);
    });
  });
}
